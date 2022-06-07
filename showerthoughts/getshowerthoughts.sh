#!/bin/bash

curl -s \
     --connect-timeout 5 \
     -A '/u/somerandomguy' \
     'https://www.reddit.com/r/showerthoughts/top.json?sort=top&t=week&limit=100' \
> ~/.dotfiles/showerthoughts/showerthoughts
cat ~/.dotfiles/showerthoughts/showerthoughts >> ~/.dotfiles/showerthoughts/showerthoughtshistory
