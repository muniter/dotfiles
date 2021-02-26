# Javier Dotfiles Author: Javier López

This install is an Ubuntu Gnome base sway wm setup.

[TOC]

## TODO:

## Deploying dotfiles
To deploy the dotfiles, cd into the dotfiles directory and use stow. 

## Applications to install:

### Using apt

#### Main Repos

- sway: wm
- swaylock: locks
- swayidle: Does something when wm is idle
- waybar: bar used
- mako: notification daemon
- notify-send: sends notifications
- wdisplays: like xrandr
- wlclipboard: clipboard manager
- brightnessctl: laptop
- playerctl: play, pause, seek, etc.
- wofi: Menu selection
- nnn: tui file manager
- fzf: Fuzzy finder
- alacritty: Terminal
- grim: screenshots
- slurp: helper for screenshots 
- git: version control
- sshfs: ssh filesystem mount
- ssh-askpass-gnome: Ask for ssh passwords
- jq: JSON utility
- zsh: shell
- fonts-powerline: Fonts for vim
- fonts-font-awesome: Fonts for vim
- tmux: terminal multiplexer
- pdfarranger: tool to arrange pdf's
- stow: manage symlinks (used in this repo)
- tldr: helper for commands tldr git
- htop: process viewer
- python3-pip: Python package manager
- snapper: btrfs snaps manager
- snapper-gui: btrfs snaps manager gui
- lm-sensors: temp, fan and pc sensors
- curl: http tool
- gparted: partition tool
- imagemagick: image manipulation tools
- mpv: music player
- mosquitto-clients: mqtt clients
- recoll: full text search app
- ripgrep: alternative to grep
- lxpolkit: polkit authentication agent
- node: nodejs
- ssh-askpass: askpass helper for sudo

```
sudo apt-get install \
    sway \
    swaylock \
    waybar \
    mako \
    notify-send \
    wdisplays \
    wlclipboard \
    swayidle \
    brightnessctl \
    playerctl \
    wofi \
    nnn \
    fzf \
    alacritty \
    grim \
    slurp \
    git \
    sshfs \
    ssh-askpass-gnome \
    jq \
    zsh \
    fonts-powerline \
    fonts-font-awesome \
    tmux \
    pdfarranger \
    stow \
    tldr \
    htop \
    arandr \
    python3-pip \
    snapper \
    snapper-gui \
    lm-sensors \
    curl \
    gparted \
    imagemagick \
    mpv \
    mosquitto-clients \
    recoll \
    ctags \
    ripgrep \
    lxpolkit \
    node \
    ssh-askpass
```

#### Alacritty Terminal

Currently not in the ubuntu repos. Can get `.deb` from `https://github.com/alacritty/alacritty/releases` the deb will take care of installing the repo.


### Using snaps

```
sudo snap install telegram-desktop spotify discord gitter gimp inkscape bitwarden bw obs-studio signal-desktop
sudo snap install --classic code skype
```

### Using pip
Youtube-dl on pip it's more updated.

```
pip3 install --user youtube-dl
pip3 install i3ipc
```

### Manually install

### oh-my-zsh

The instruction can be found in the [official site](https://ohmyz.sh/#install) but boil down to:

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### docker-ce

Setting up docker using the auto install script

```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt install docker-compose
#This commands make it runnable without sudo
sudo usermod -aG docker muniter ```
```

### neovim

I install from source. Visit [Project Page](https://github.com/neovim/neovim) for instructions.

Installing VimPlug, plugin manager.

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Mako

In Ubuntu 20.04 there's an apparmor problem. So It must be disabled for mako `sudo aa-disable /etc/apparmor.d/fr.emersion.Mako`

1. Telegram: There's a setting that tells it to use the native notifications (DBus)
1. Firefox: When libnotify it's intalled firefox will use the native notifications.

### Sudo

The following additions are needed for the **remaps** script and **brightnessctl**, to run as sudo without asking for password.

> It's very important to note that having a `. or ~` in the name will cause sudo to node include the file.

**/etc/sudoers.d/sway**

```bash
# Run brightnessctl commands as root whitout password
muniter localhost=(root) NOPASSWD: /usr/bin/brightnessctl /home/muniter/scripts/remaps.py
# for user muniter, on host localhost run as root without password the commands brightnessctl and remaps.py
```

I also like to define an askpass helper for sudo.

```bash
# Run command
sudo sudoedit /etc/sudo.conf
```

**/etc/sudo.conf**:

```
# Add the following line
Path askpass /usr/bin/ssh-askpass
```

### Snapper and btrfs

All info can be easily found in `man snapper`

1. Deploy configurations this repo has them in `/snapper`. By putting them in `/etc/snapper/configs/`
2. Change entries in fstab, make sure to add "snapshots" mount.

file: **/etc/fstab**
```
# / was on /dev/nvme0n1p2 during installation
UUID=<uuid> /               btrfs   defaults,subvol=@ 0       1
# For Snapshots
UUID=<uuid> /.snapshots     btrfs   subvol=/@/.snapshots 0       1
```

3. In grub (WIP) find a way to change `GRUB_CMDLINE_LINUX="rootflags=subvol=${rootsubvol} ${GRUB_CMDLINE_LINUX}"`. Since this causes issue making rollbacks not work, because it hard codes the root subvolume.


### Remaps

The remap script to have Tab and Backslash as super when hold, and normal action when pressed. We can append to the previous example the following.

> It's very important to note that having a `. or ~` in the name will cause sudo to node include the file.

**/etc/sudoers.d/sway**


