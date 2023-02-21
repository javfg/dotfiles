#!/bin/bash

cowsay -f $(ls /usr/share/cows/ | shuf -n 1) $(~/.dotfiles/bin/common/showerthoughts/showerthoughts.py) | lolcat
