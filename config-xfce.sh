#!/usr/bin/env bash
#
# lastmod: 2019-07-07T22:22:20+02:00

# config plank
# see also https://wiki.archlinux.org/index.php/Plank
cat ./dotfiles/config/plank/plank.ini | dconf load /net/launchpad/plank/docks/
if [[ -d  ~/.config/plank ]]; then rm -rf ~/.config/plank; fi
ln -sf $(pwd)/dotfiles/config/plank ~/.config/plank

# copy xfce4 config files
cp -rf ./dotfiles/config/xfce4/* ~/.config/xfce4

# qt config
cp -rf ./dotfiles/config/qt5ct/* ~/.config/qt5ct
