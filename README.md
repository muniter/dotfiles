# Javier Dotfiles

Author: Javier López

This install is an Ubuntu base i3 wm setup.

## Deploying dotfiles
To deploy the dotfiles, cd into the dotfiles directory and use stow. 

### Vim
Stow vim, open and then run :PluginInstall to reinstall the extensions.

## Applications to install:

### Using aptitude

i3, i3-gaps, dmenu, rofill, compton, feh, scrot, xclip, urxvt, unclutter, autocutsel, ranger, tmux, remmina, pdfshuffler, lxappearance, gtk-chtheme, qt4-qtconfig, tldr, iotop, htop, arandr, xcape, git, stow, rtv, sensors, curl, gparted, imagemagick, taskwarrior, weechat, i3blocks, mpv, youtube-dl, nnn, pandoc

```
sudo apt install -y i3 dmenu rofi compton feh git xfce4-terminal scrot xclip vim-gtk3 \
unclutter autocutsel tmux pdfshuffler stow lxappearance gtk-chtheme \
qt4-qtconfig tldr iotop htop arandr xcape python3-pip openssh-server blueman \
qutebrowser snapper lm-sensors curl gparted imagemagick pasystray \
mpv pandoc
```
### Using snaps
```
sudo snap install telegram-desktop remmina spotify discord gimp libreoffice bitwarden
sudo snap install --classic code
```
### Using pip
Youtube-dl on pip it's more updated.
```
pip3 install --user pywal youtube-dl
pip3 install psutil
```

### Manually install

#### i3-gaps

Since there is no package for ubuntu, it must be compiled from source, the instructions can be found in the [i3-gaps wiki](https://github.com/Airblader/i3/wiki/Building-from-source)

#### nnn

nnn can be found in the repos, but for 18.04 is too outdated, so we install from source
```
sudo apt-get install pkg-config libncursesw5-dev libreadline6-dev
make
sudo make install
```

#### docker-ce
Setting up docker using the auto install script
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt install docker-compose
#This commands make it runnable without sudo
sudo usermod -aG docker muniter ```
```
#### Fzf
Fuzzy finder

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/programs/fzf
~/programs/fzf/install
```

## Setup

Some thing to setup after the installation

### Setting up the fish shell as default
chsh -s /usr/bin/fish


### Setting up fstab
When mounting ntfs shares, make sure to use the following permissions so the files are not mounted as root.

```
#Mounting hdd1 and hdd2
UUID=72072E91671C6B8B	/media/2hdd	ntfs	defaults,nls=utf8,umask=000,dmask=027,fmask=137,uid=1000,gid=1000	0	0
UUID=735D0E7D595559FE	/media/1hdd	ntfs	defaults,nls=utf8,umask=000,dmask=027,fmask=137,uid=1000,gid=1000	0	0
``

