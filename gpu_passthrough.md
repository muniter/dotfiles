# Setting up Gpu Passthrough and block device WIN10 Ryzen

For a very detailed and explained guide follow [Mathias Hueber guide](https://mathiashueber.com/ryzen-based-virtual-machine-passthrough-setup-ubuntu-18-04/)

## Enable IOMMU and other boot parameters

First step is to enable iommu on the boot parameters of grub in this case, the kvm.ignore parameter is to avoid BSOD from windows

In **/etc/default/grub** modify so it looks like:

```
GRUB_CMDLINE_LINUX_DEFAULT="amd_iommu=on iommu=pt kvm.ignore_msrs=1"
```

Then update grub
```
sudo update-grub
```

##  Download and install KVM and OVMF

Perform the installation of the neccessary packages

```
apt install -y virt-manager qemu-kvm libvirt-bin bridge-utils ovmf
```

## Checking IOMMU Groups

Checking that iommu is enabled after reboot and check thtat the groups are valid running the following command. 

To check if IOMMU is enabled:

```
dmesg | grep -e DMAR -e IOMMU 
```

The following snippet checks for the iommu groups organization
```
for iommu_group in $(find /sys/kernel/iommu_groups/ -maxdepth 1 -mindepth 1 -type d); do echo "IOMMU group $(basename "$iommu_group")"; for device in $(ls -1 "$iommu_group"/devices/); do echo -n $'\t'; lspci -nns "$device"; done; done 
```
In this case my Groups for Vega 64 on the X470 Gaming Pro (MSI) are:

IOMMU group 16

	1f:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Vega [Radeon RX Vega] [1002:687f] (rev c1)

IOMMU group 17

	1f:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Device [1002:aaf8]

And for the K4000 Nvidia
IOMMU group 18

	20:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK106GL [Quadro K4000] [10de:11fa] (rev a1)

	20:00.1 Audio device [0403]: NVIDIA Corporation GK106 HDMI Audio Controller [10de:0e0b] (rev a1)

*In this case the audio and video are in the same iommu group, that's not a problem since we're going to pass both throught*


## Isolating the gpu.

Create the file **/etc/modprobe.d/vfio.conf** and add the following lines, that will attach the vfio-pci driver to the selected GPU
```
options vfio-pci ids=10de:11fa,10de:0e0b
```
To avoid that nouveau or amdgpu takes possession of the GPU we add to the same file **/etc/modprobe.d/vfio.conf** 
```
blacklist nouveau
options nouveau modeset-0
```
*This is so that it loads first than the previous drivers*

This is how vfio.conf looks
```
#---RX Vega 64----#
options vfio-pci ids=1002:687f,1002:aaf8
softdep amdgpu pre: vfio vfio_pci

#---Quadro K4000----#
#This is for the Quadro K4000
options vfio-pci ids=10de:11fa,10de:0e0b
softdep nouveau pre: vfio vfio_pci

#---Black Listing---#
blacklist nouveau
```

Also modify in **/etc/default/grub** so that we specify the vfio pci in `GRUB_CMDLINE_LINUX_DEFAUL`

```
GRUB_CMDLINE_LINUX_DEFAULT="amd_iommu=on iommu=pt kvm.ignore_msrs=1 vfio_pci.ids=10de:11fa,10de:0e0b,1002:687f,1002:aaf8"
```

### Checking If it Worked

To check if our configuration worked, we have to check if the Kernel driver in use for our devices is `vfio_pci` running the following command:

```
lspci -nnk
```
## Passing throught a complete block device 

To use a complete block device as the hard drive first get the id of the disk to be passed. Is better to use ID because it doesn't change

```
ls -l /dev/disk/by-id
```

First apparmor must be modified to allow rw access to the block device, in the file **/etc/apparmor.d/abstractions/libvirt-qemu.**

Add under "for usb access"
```
/dev/*disk-id* rw,
```
## Passing throught a USB Controller

Run the same command to get the iommu groups and look for a group that only has a USB controller, since the minimum unit you can pass to a VM is an iommu group.
```
for iommu_group in $(find /sys/kernel/iommu_groups/ -maxdepth 1 -mindepth 1 -type d); do echo "IOMMU group $(basename "$iommu_group")"; for device in $(ls -1 "$iommu_group"/devices/); do echo -n $'\t'; lspci -nns "$device"; done; done 
```

In my case I get group 21, so I will be passing the device with the id 20:00.3
```
IOMMU group 21
        20:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] USB 3.0 Host controller [1022:145f]
```

## Setting up the network bridge
*For more [libvirt Networking Handbook](https://jamielinux.com/docs/libvirt-networking-handbook/bridged-network.html)*

Add the following to **/etc/network/interfaces** and then reboot

```
auto br10
iface br10 inet dhcp
	bridge_ports $IFACE
	bridge_stp 0
	bridge_fd 0
	bridge_maxwait 0
```
### Allow routing from the host
Also to allow routing from host to the rest of the network, create **/etc/sysctl.d/bridge.conf** and add the following parameters, that decide wether packets traversing the bridge go to the iptables for processing. There's a problem that when sysctl -p is run in the boot process the bridge might not be up, and the command is executed, so we also have to use udev to run sysctl -p /etc/sysclt.d/bridge.conf.

```
#Added by $USER
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
```
Create **/etc/udev/rules.d/99-bridge.rules** with the following contents. This udev rule applies the sysctl settings above when the bridge module is loaded. 
```
#Added by $USER
ACTION=="add", SUBSYSTEM=="module", KERNEL=="br_netfilter", RUN+="/sbin/sysctl -p /etc/sysctl.d/bridge.conf"
```

Add into **/etc/modules** *br_netfilter* to allow for loading this module previous to sysctl -p execution
```
br_netfilter
```

## Domain XML example (With half the cpu allocations)

For more detailed information in the changes performed in this XML, read [this guide](https://mathiashueber.com/cpu-pinning-on-amd-ryzen/#Virtual-machine-CPU-configuration)

```
<domain type='kvm'>
  <name>win10</name>
  <uuid>d14fe463-70db-4bf2-95a2-d073b1469575</uuid>
  <memory unit='KiB'>6144000</memory>
  <currentMemory unit='KiB'>6144000</currentMemory>
  <vcpu placement='static'>8</vcpu>
  <iothreads>1</iothreads>
  <cputune>
    <vcpupin vcpu='0' cpuset='8'/>
    <vcpupin vcpu='1' cpuset='9'/>
    <vcpupin vcpu='2' cpuset='10'/>
    <vcpupin vcpu='3' cpuset='11'/>
    <vcpupin vcpu='4' cpuset='12'/>
    <vcpupin vcpu='5' cpuset='13'/>
    <vcpupin vcpu='6' cpuset='14'/>
    <vcpupin vcpu='7' cpuset='15'/>
    <emulatorpin cpuset='0-1'/>
    <iothreadpin iothread='1' cpuset='0-1'/>
  </cputune>
  <os>
    <type arch='x86_64' machine='pc-q35-2.11'>hvm</type>
    <loader readonly='yes' type='pflash'>/usr/share/OVMF/OVMF_CODE.fd</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/win10_VARS.fd</nvram>
    <boot dev='hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <hyperv>
      <relaxed state='on'/>
      <vapic state='on'/>
      <spinlocks state='on' retries='8191'/>
    </hyperv>
    <vmport state='off'/>
  </features>
  <cpu mode='host-passthrough' check='none'>
    <topology sockets='1' cores='4' threads='2'/>
    <cache level='3' mode='emulate'/>
  </cpu>
  <clock offset='localtime'>
    <timer name='rtc' tickpolicy='catchup'/>
    <timer name='pit' tickpolicy='delay'/>
    <timer name='hpet' present='no'/>
    <timer name='hypervclock' present='yes'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <pm>
    <suspend-to-mem enabled='no'/>
    <suspend-to-disk enabled='no'/>
  </pm>
  <devices>
    <emulator>/usr/bin/kvm-spice</emulator>
    <disk type='block' device='disk'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source dev='/dev/disk/by-id/ata-LITEONIT_LCS-256M6S_2.5_7mm_256GB_TW0XFJWX550853810518'/>
      <target dev='sda' bus='sata'/>
      <address type='drive' controller='0' bus='0' target='0' unit='0'/>
    </disk>
    <controller type='usb' index='0' model='ich9-ehci1'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1d' function='0x7'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci1'>
      <master startport='0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1d' function='0x0' multifunction='on'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci2'>
      <master startport='2'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1d' function='0x1'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci3'>
      <master startport='4'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1d' function='0x2'/>
    </controller>
    <controller type='sata' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1f' function='0x2'/>
    </controller>
    <controller type='pci' index='0' model='pcie-root'/>
    <controller type='pci' index='1' model='dmi-to-pci-bridge'>
      <model name='i82801b11-bridge'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1e' function='0x0'/>
    </controller>
    <controller type='pci' index='2' model='pci-bridge'>
      <model name='pci-bridge'/>
      <target chassisNr='2'/>
      <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
    </controller>
    <controller type='pci' index='3' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='3' port='0x10'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0' multifunction='on'/>
    </controller>
    <controller type='pci' index='4' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='4' port='0x11'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x1'/>
    </controller>
    <controller type='pci' index='5' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='5' port='0x12'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x2'/>
    </controller>
    <controller type='virtio-serial' index='0'>
      <address type='pci' domain='0x0000' bus='0x03' slot='0x00' function='0x0'/>
    </controller>
    <interface type='bridge'>
      <mac address='52:54:00:ad:95:62'/>
      <source bridge='br10'/>
      <model type='rtl8139'/>
      <address type='pci' domain='0x0000' bus='0x02' slot='0x01' function='0x0'/>
    </interface>
    <serial type='pty'>
      <target type='isa-serial' port='0'>
        <model name='isa-serial'/>
      </target>
    </serial>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
    <channel type='spicevmc'>
      <target type='virtio' name='com.redhat.spice.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='1'/>
    </channel>
    <input type='tablet' bus='usb'>
      <address type='usb' bus='0' port='1'/>
    </input>
    <input type='mouse' bus='ps2'/>
    <input type='keyboard' bus='ps2'/>
    <graphics type='spice' autoport='yes'>
      <listen type='address'/>
      <image compression='off'/>
    </graphics>
    <sound model='ich6'>
      <address type='pci' domain='0x0000' bus='0x02' slot='0x02' function='0x0'/>
    </sound>
    <video>
      <model type='qxl' ram='65536' vram='65536' vgamem='16384' heads='1' primary='yes'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0'/>
    </video>
    <redirdev bus='usb' type='spicevmc'>
      <address type='usb' bus='0' port='2'/>
    </redirdev>
    <redirdev bus='usb' type='spicevmc'>
      <address type='usb' bus='0' port='3'/>
    </redirdev>
    <memballoon model='virtio'>
      <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
    </memballoon>
  </devices>
</domain>
```
