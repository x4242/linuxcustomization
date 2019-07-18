#!/usr/bin/env bash
#
# description: install and config tools for daily/std use + personalization
# lastmod: 2019-07-18T10:50:16+02:00
# change history:
#  - 2019-07-18: added shellcheck
#  - 2019-07-18: created, moved from personal-setup.sh

# String definitions for colored printf output
# [ ERROR ] in red
# [ INFO  ] in green
# [ INPUT ] in yellow
STR_ERROR="[ \e[31mERROR\e[0m ]"
STR_INFO="[ \e[32mINFO\e[0m  ]"
STR_INPUT="[ \e[1;33mINPUT\e[0m ]"

printf "%s Installing standard packages...\n" "${STR_INFO}"

##########################################
# Install common tools
##########################################
printf "%s Installing common packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed plank

##########################################
# Install misc tools
##########################################
printf "%s Installing misc. packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed nextcloud-client
sudo pacman -S --noconfirm --needed keepassxc
sudo pacman -S --noconfirm --needed pandoc

##########################################
# Install dev tools
##########################################
printf "%s Installing development packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed atom
sudo pacman -S --noconfirm --needed hugo
sudo pacman -S --noconfirm --needed php
sudo pacman -S --noconfirm --needed python-pylint
sudo pacman -S --noconfirm --needed shellcheck

##########################################
# Install AUR customizations
##########################################
printf "%s Installing AUR customization packages...\n" "${STR_INFO}"
yay -S --noconfirm equilux-theme
yay -S --noconfirm ttf-roboto-mono

printf "%s Done installing standard packages.\n" "${STR_INFO}"
exit 0
