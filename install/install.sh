#!/bin/bash

if type pacman > /dev/null 2>&1; then
  package_list=( most nano vim tmux git fd rust thefuck bat xsel rlwrap difftastic fd wmctrl rust python-pip )
else
  package_list=( most nano vim tmux git fd rust )
fi

install_packages() {
  if type pacman > /dev/null 2>&1; then
    sudo pacman -Syy --noconfirm $@
  elif type apt > /dev/null 2>&1; then
    sudo apt --assume-yes install $@
  elif type yum > /dev/null 2>&1; then
    sudo yum -y install $@
  fi
}

# install required system-wide distro packages
install_packages $package_list

# install oh-my-zsh...
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ...and its plugins...
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/paulirish/git-open.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open

# and theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# install fzf - phasing out
# git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
# $HOME/.fzf/install --key-bindings --completion --no-update-rc

# install mcfly
curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly

# install tere
cargo install tere

# install thefuck
pip install thefuck

# install cheat.sh client
sudo curl -s https://cht.sh/:cht.sh -o /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# configure difftastic for git
if type difft > /dev/null 2>&1; then
  git config --global diff.external difft
fi

# install missing packages in centos
elif type yum > /dev/null 2>&1; then
  cargo install fd-find
fi

cp global/gitconfig $HOME/.gitconfig
