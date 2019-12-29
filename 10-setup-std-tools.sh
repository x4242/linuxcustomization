#!/usr/bin/env bash

# Description:
# ------------
# install and config tools for daily/std use + personalization
#
# lastmod: 2019-09-08T11:00:10+02:00
# Change History:
# ---------------
#  - 2019-09-08:
#    - added pacman/yay db sync prior to install
#    - added clamav, firewalld
#  - 2019-07-27: added hunspell dictionaries fpr spell checking
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

# sync databases
sudo pacman -Sy

printf "%b Installing standard packages...\n" "${STR_INFO}"

##########################################
# Install common tools
##########################################
printf "%b Installing common packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed grc
sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed plank
sudo pacman -S --noconfirm --needed hunspell-de
sudo pacman -S --noconfirm --needed hunspell-en_US

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

# pip for python2
sudo python2 -m ensurepip

##########################################
# Install security tools
##########################################
printf "%b Installing security packages...\n" "${STR_INFO}"
# install, enable and update clamav
sudo pacman -S --noconfirm --needed clamav
sudo systemctl enable clamav-daemon.service
sudo systemctl start clamav-daemon.service
sudo freshclam
# install, enable firewalld
sudo pacman -S --noconfirm --needed firewalld
sudo systemctl enable firewalld.service
sudo systemctl start firewalld.service

##########################################
# Install AUR packages
##########################################
bash ./91-helper-check-installed.sh yay
if [[ $? == 0 ]]; then
  yay -Sy
  printf "%b Installing AUR customization packages...\n" "${STR_INFO}"
  yay -S --noconfirm equilux-theme
  yay -S --noconfirm ttf-roboto-mono
else
  printf "%b Couldn't install AUR packages as 'yay' is not installed.\n" "${STR_ERROR}" >&2
  exit 1
fi

printf "%b Done installing standard packages.\n" "${STR_INFO}"
exit 0
