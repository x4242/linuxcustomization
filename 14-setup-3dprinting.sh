#!/usr/bin/env bash

# Description:
# ------------
# install and config 3d printign tools
#
# lastmod: 2019-12-29T13:00:11+01:00
# Change History:
# ---------------
#  - 2019-12-29: created

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

# sync databases
sudo pacman -Sy

printf "%b Installing 3d printing packages...\n" "${STR_INFO}"

##########################################
# Official packages
##########################################
printf "%b Installing official packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed cura
sudo pacman -S --noconfirm --needed blender
sudo pacman -S --noconfirm --needed openscad
sudo pacman -S --noconfirm --needed boost # dep. for slic3r, ins't solved by yay


##########################################
# Install AUR packages
##########################################
bash ./91-helper-check-installed.sh yay
if [[ $? == 0 ]]; then
  yay -Sy
  printf "%b Installing AUR packages...\n" "${STR_INFO}"
  yay -S --noconfirm slic3r
  yay -S --noconfirm printrun
  yay -S --noconfirm freecad
else
  printf "%b Couldn't install AUR packages as 'yay' is not installed.\n" "${STR_ERROR}" >&2
  exit 1
fi

printf "%b Done installing 3d printing packages.\n" "${STR_INFO}"
exit 0
