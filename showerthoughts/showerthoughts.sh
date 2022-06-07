#!/bin/bash

cowsay -f $(ls /usr/share/cows/ | shuf -n 1) $($HOME/.dotfiles/showerthoughts/showerthoughts.py) | lolcat
