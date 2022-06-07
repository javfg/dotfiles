#!/bin/bash

export OS=$(cat /etc/os-release | grep -E '^NAME' | cut -d'"' -f 2)

install_package() {
  if [ "$OS" = "Arch Linux" ]; then
    sudo pacman -Syy --noconfirm $@
  elif [ "$OS" = "Ubuntu" ]; then
    sudo apt --assume-yes install $@
  elif [ "$OS" = "CentOS Linux" ]; then
    sudo yum -y install $@
  fi
}

# install required system-wide distro packages
package_list=( most nano vim tmux git fd )
install_package $f

# install oh-my-zsh...
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ...and its plugins...
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# and theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
