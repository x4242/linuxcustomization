#!/usr/bin/env bash

# Description:
# ------------
# install and config tools for daily/std use + personalization
#
# lastmod: 2019-07-20T21:36:38+02:00
# Change History:
# ---------------
#  - 2019-07-20: printf corrections
#  - 2019-07-18: added shellcheck
#  - 2019-07-18: created, moved from personal-setup.sh

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

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
# Install AUR customizations
##########################################
printf "%b Installing AUR customization packages...\n" "${STR_INFO}"
yay -S --noconfirm equilux-theme
yay -S --noconfirm ttf-roboto-mono

printf "%b Done installing standard packages.\n" "${STR_INFO}"
exit 0
