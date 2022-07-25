#!/bin/bash

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
package_list=( most nano vim tmux git fd thefuck rust )
install_packages $package_list

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
$HOME/.fzf/install --key-bindings --completion --no-update-rc

# install tere
cargo install tere
