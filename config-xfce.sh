#!/usr/bin/env bash

# lastmod: 2019-06-23T11:02:56+02:00

# add autostart entries
if [[ ! -d  ~/.config/autostart ]]; then mkdir  ~/.config/autostart; fi
cp ./dotfiles/config/autostart/* ~/.config/autostart

# config plank
# see also https://wiki.archlinux.org/index.php/Plank
cat ./dotfiles/plank/plank.ini | dconf load /net/launchpad/plank/docks/
if [[ ! -d  ~/.config/plank/dock1/launchers ]]; then mkdir  ~/.config/plank/dock1/launchers; fi
cp ./dotfiles/plank/dock1/launchers/* ~/.config/plank/dock1/launchers
