if [ "$EUID" -eq 0 ]; then
  echo "Please do not run as root."
  exit
fi

[ ! -z "$1" ] && REPO=$1 || REPO="/repo"
[ ! -z "$XDG_CONFIG_HOME" ] && XDG=$XDG_CONFIG_HOME || XDG=$HOME/.config

# update the system
sudo pacman --noconfirm -Syyu

# install core dependencies
sudo pacman --noconfirm -S base-devel git curl

# make sure repo folder exists
sudo mkdir -p $REPO
sudo chmod 775 $REPO

# pull and install yay
if cd $REPO/yay; then
  git pull
else
  git clone https://aur.archlinux.org/yay.git $REPO/yay
  cd $REPO/yay
fi
makepkg --noconfirm -si

# pull my system configuration
if cd $REPO/system; then
  git pull
else
  git clone https://github.com/ianzano/system.git $REPO/system
fi

# download antigen
sudo curl -L git.io/antigen > $REPO/antigen.zsh

# link my zsh configuration
sudo mkdir -p /etc/zsh
sudo rm -rf /etc/zsh/zshrc
sudo ln -s $REPO/system/filesystem/etc/zsh/zshrc /etc/zsh/zshrc
touch $HOME/.zshrc

# pull AstroNvim (neovim plugins)
if cd $REPO/AstroNvim; then
  git pull
else
  git clone https://github.com/AstroNvim/AstroNvim.git $REPO/AstroNvim
fi

# link AstroNvim
sudo rm -rf $XDG/nvim
ln -s $REPO/AstroNvim $XDG/nvim

# link my AstroNvim configuration
sudo rm -rf $REPO/AstroNvim/lua/user
sudo ln -s $REPO/system/filesystem/repo/AstroNvim/lua/user $REPO/AstroNvim/lua/user

# install php
yay --noconfirm -S php-fpm apache phpactor composer

# pull tpm (tmux package manager)
if cd $REPO/tpm; then
  git pull
else
  git clone https://github.com/tmux-plugins/tpm $REPO/tpm
fi

# link my tmux configuration
mkdir -p $XDG/tmux
sudo rm -rf $XDG/tmux/tmux.conf
ln -s $REPO/system/filesystem/etc/tmux.conf $XDG/tmux/tmux.conf
