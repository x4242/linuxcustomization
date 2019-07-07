#!/usr/bin/env bash
#
# lastmod: 2019-06-23T11:02:56+02:00

# config plank
# see also https://wiki.archlinux.org/index.php/Plank
cat ./dotfiles/plank/plank.ini | dconf load /net/launchpad/plank/docks/
if [[ -d  ~/.config/plank ]]; rm -rf ~/.config/plank; fi
ln -s ./dotfiles/plank ~/.config/plank

unalias cp
# copy xfce4 config files
cp -rf ./dotfiles/xfce/* ~/.config/xfce4

# qt config
cp -rf ./dotfiles/qt5ct/* ~/.config/qt5ct

alias cp='cp -i'
