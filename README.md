# Javier Dotfiles Author: Javier López

This install is an Ubuntu base sway wm setup.

## TODO:

- [ ] How to deploy snapper configuration.
- [ ] Documentation on remap script.
- [x] Document how to setup sudoers file to run apps as root, whitout password.
- [ ] Instruction for installing and setting up recoll.
- [ ] Reformat this file better.

## Deploying dotfiles
To deploy the dotfiles, cd into the dotfiles directory and use stow. 

## Applications to install:

### Using apt

#### Main Repos

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
    neovim \
    zsh \ 
    python3-neovim \
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
    node 
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

I can install neovim from the [repositories](https://github.com/neovim/neovim), but I also like to use the nightly version.
The plugin manager VimPlug must first be installed:

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Mako

In Ubuntu 20.04 there's an apparmor problem. So It must be disabled for mako `sudo aa-disable /etc/apparmor.d/fr.emersion.Mako`

1. Telegram: There's a setting that tells it to use the native notifications (DBus)
1. Firefox: When libnotify it's intalled firefox will use the native notifications.

### Sudo

The following additions are needed for the **remaps** script and **brightnessctl*, to run as sudo without asking for password.

> It's very important to note that having a `. or ~` in the name will cause sudo to node include the file.

file: **/etc/sudoers.d/sway**

```bash
# Run brightnessctl commands as root whitout password
muniter localhost=(root) NOPASSWD: /usr/bin/brightnessctl /home/muniter/scripts/remaps.py
# for user muniter, on host localhost run as root without password the commands brightnessctl and remaps.py
```bash

### Remaps

The remap script to have Tab and Backslash as super when hold, and normal action when pressed. We can append to the previous example the following.

> It's very important to note that having a `. or ~` in the name will cause sudo to node include the file.

**/etc/sudoers.d/sway**

