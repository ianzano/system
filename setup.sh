if [ "$EUID" -eq 0 ]; then
  echo "Please do not run as root."
  exit
fi

[ ! -z "$1" ] && REPO_FOLDER=$1 || REPO_FOLDER="/repo"
[ ! -z "$XDG_CONFIG_HOME" ] && XDG=$XDG_CONFIG_HOME || XDG=$HOME/.config

# update the system
sudo pacman --noconfirm -Syyu

# install core dependencies
sudo pacman --noconfirm -S base-devel git curl

# make sure repo folder exists
sudo mkdir -p $REPO_FOLDER
sudo chmod 775 $REPO_FOLDER

# pull and install yay
if cd $REPO_FOLDER/yay; then
  git pull
else
  git clone https://aur.archlinux.org/yay.git $REPO_FOLDER/yay
  cd $REPO_FOLDER/yay
fi
makepkg --noconfirm -si

# pull my system configuration
if cd $REPO_FOLDER/system; then
  git pull
else
  git clone https://github.com/ianzano/system.git $REPO_FOLDER/system
fi

# download antigen
sudo curl -L git.io/antigen > $REPO_FOLDER/antigen.zsh

# link my zsh configuration
sudo mkdir -p /etc/zsh
sudo rm -rf /etc/zsh/zshrc
sudo ln -s $REPO_FOLDER/system/filesystem/etc/zsh/zshrc /etc/zsh/zshrc
touch $HOME/.zshrc

# pull AstroNvim (neovim plugins)
if cd $REPO_FOLDER/AstroNvim; then
  git pull
else
  git clone https://github.com/AstroNvim/AstroNvim.git $REPO_FOLDER/AstroNvim
fi

# link AstroNvim
sudo rm -rf $XDG/nvim
sudo ln -s $REPO_FOLDER/AstroNvim $XDG/nvim

# link my AstroNvim configuration
sudo rm -rf $REPO_FOLDER/AstroNvim/lua/user
sudo ln -s $REPO_FOLDER/system/filesystem/repo/AstroNvim/lua/user $REPO_FOLDER/AstroNvim/lua/user

# install php
yay --noconfirm -S php-fpm apache phpactor composer

# pull tpm (tmux package manager)
if cd $REPO_FOLDER/tpm; then
  git pull
else
  git clone https://github.com/tmux-plugins/tpm $REPO_FOLDER/tpm
fi

# link my tmux configuration
sudo rm -rf $XDG/tmux/tmux.conf
sudo rm -rf /etc/tmux.conf
sudo ln -s $REPO_FOLDER/system/filesystem/etc/tmux.conf /etc/tmux.conf
