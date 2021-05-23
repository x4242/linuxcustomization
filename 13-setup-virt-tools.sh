#!/usr/bin/env bash

# Description:
# ------------
# installation and configuration of virtualization packages
#
# lastmod:2019-09-08T11:17:34+02:00
# Change History:
# ---------------
#   - 2019-09-08: added pacman/yay db snc prior to install
#   - 2019-07-21: added sudo/root check
#   - 2019-07-20: prtinf corrections
#   - 2019-07-18: created

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
#STR_INPUT="[ \e[93mINPUT\e[0m ]"

##########################################
# Check if root / sudo
##########################################
if [ "$EUID" -eq 0 ]; then
  printf "%b Do not run with sudo / as root.\n" "${STR_ERROR}" >&2
  exit 1
fi

sudo pacman -Sy

printf "%b Installing virtualization packages...\n" "${STR_INFO}"

sudo pacman -S --noconfirm --needed qemu
sudo pacman -S --noconfirm --needed libvirt
sudo pacman -S --noconfirm --needed virt-manager

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

printf "%b Done installing virtualization packages.\n" "${STR_INFO}"
exit 0
