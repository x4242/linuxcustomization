#!/usr/bin/env bash

# Description:
# ------------
# installation and configuration of virtualization packages
#
# lastmod: 2019-07-20T21:39:21+02:00
# Change History:
# ---------------
#   - 2019-07-20: prtinf corrections
#   - 2019-07-18: created

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

printf "%b Installing virtualization packages...\n" "${STR_INFO}"

sudo pacman -S --noconfirm --needed qemu
sudo pacman -S --noconfirm --needed libvirt
sudo pacman -S --noconfirm --needed virt-manager

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

printf "%b Done installing virtualization packages.\n" "${STR_INFO}"
exit 0
