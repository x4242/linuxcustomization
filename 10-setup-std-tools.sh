#!/usr/bin/env bash

# Description:
# ------------
# install and config tools for daily/std use + personalization
#
# lastmod: 2019-07-21T13:24:44+02:00
# Change History:
# ---------------
#  - 2019-07-21: added check if yay is installed and root/sudo
#  - 2019-07-20:
#    - added flameshot
#    - printf corrections
#  - 2019-07-18: added shellcheck
#  - 2019-07-18: created, moved from personal-setup.sh

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

##########################################
# Check if root / sudo
##########################################
if [ "$EUID" -eq 0 ]; then
  printf "%b Do not run with sudo / as root.\n" "${STR_ERROR}" >&2
  exit 1
fi

printf "%b Installing standard packages...\n" "${STR_INFO}"

##########################################
# Install common tools
##########################################
printf "%b Installing common packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed plank

##########################################
# Install misc tools
##########################################
printf "%b Installing misc. packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed nextcloud-client
sudo pacman -S --noconfirm --needed keepassxc
sudo pacman -S --noconfirm --needed pandoc
sudo pacman -S --noconfirm --needed flameshot

##########################################
# Install dev tools
##########################################
printf "%b Installing development packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed atom
sudo pacman -S --noconfirm --needed hugo
sudo pacman -S --noconfirm --needed php
sudo pacman -S --noconfirm --needed python-pylint
sudo pacman -S --noconfirm --needed shellcheck

##########################################
# Install AUR packages
##########################################
bash ./91-helper-check-installed.sh yay
if [[ $? == 0 ]]; then
  printf "%b Installing AUR customization packages...\n" "${STR_INFO}"
  yay -S --noconfirm equilux-theme
  yay -S --noconfirm ttf-roboto-mono
else
  printf "%b Couldn't install AUR packages as 'yay' is not installed.\n" "${STR_ERROR}" >&2
  exit 1
fi

printf "%b Done installing standard packages.\n" "${STR_INFO}"
exit 0
