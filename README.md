# Javier Dotfiles Author: Javier López

This install is an Ubuntu base i3 wm setup.

## Deploying dotfiles
To deploy the dotfiles, cd into the dotfiles directory and use stow. 

ADD BRIGHTNESSCTL

## Applications to install:

### Using aptitude

#### Alacritty Terminal

Currently not in the ubuntu repos. Can get `.deb` from `https://github.com/alacritty/alacritty/releases`

#### Main Repos

```
sudo apt-get install \
	sway \
	swaylock \
	waybar \
	mako \
	wdisplays \
	wlclipboard \
	swayidle \
	brightnessctl \ 
	playerctl
	wofi \
	nnn \
	fzf \
	grim \
	slurp \
	git \
	sshfs \
	ssh-askpass-gnome \
	jq \
	neovim \
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
	lm-sensors \
	curl \
	gparted \
	imagemagick \
	mpv \
	mosquitto \
	recoll
```
### Using snaps
```
sudo snap install telegram-desktop spotify discord gimp inkscape bitwarden
```

### Using pip
Youtube-dl on pip it's more updated.
```
pip3 install --user youtube-dl
```

### Manually install

#### docker-ce
Setting up docker using the auto install script
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt install docker-compose
#This commands make it runnable without sudo
sudo usermod -aG docker muniter ```
```
### Vim
The plugin manager VimPlug must first be installed:

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

##### coc-nvim

The main plugin I use on my vim setup requires, nodejs and npm.

```bash
sudo apt install npm nodejs
# Alternative use snap
snap install nodejs 
# It also needs an npm package
npm install -g neovim
```

To check everythins is working `:checkhealth`.

### Recoll

INSTRUCTIONS FOR RECOLL

### Brightess

To control the brighness of the display we use `brightnessctl` which requires root access for obvious reasons. We define a rule in the sudoers file:

**/etc/sudoers.d/sway**

```bash
# Run brightness commands as root whitout password
muniter ALL=(root) NOPASSWD: /usr/bin/brightnessctl
```
