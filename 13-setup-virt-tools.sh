#!/usr/bin/env bash
#
# description: installation and configuration of virtualization packages
# lastmod: 2019-07-18T22:32:20+02:00
# change history:
#  - 2019-07-18: created

# String definitions for colored printf output
# [ ERROR ] in red
# [ INFO  ] in green
# [ INPUT ] in yellow
STR_ERROR="[ \e[31mERROR\e[0m ]"
STR_INFO="[ \e[32mINFO\e[0m  ]"
STR_INPUT="[ \e[1;33mINPUT\e[0m ]"

printf "%s Installing virtualization packages...\n" "${STR_INFO}"

sudo pacman -S --noconfirm --needed qemu
sudo pacman -S --noconfirm --needed libvirt
sudo pacman -S --noconfirm --needed virt-manager

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

printf "%s Done installing virtualization packages.\n" "${STR_INFO}"
exit 0
