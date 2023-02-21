#!/bin/bash

curl -s \
     --connect-timeout 5 \
     -A '/u/somerandomguy' \
     'https://www.reddit.com/r/showerthoughts/top.json?sort=top&t=week&limit=100' \
> ~/.dotfiles/bin/common/showerthoughts/showerthoughts
cat ~/.dotfiles/bin/common/showerthoughts/showerthoughts >> ~/.dotfiles/bin/common/showerthoughts/showerthoughtshistory
