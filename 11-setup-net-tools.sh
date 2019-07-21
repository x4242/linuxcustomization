#!/usr/bin/env bash

# Description:
# ------------
# tbd
#
# lastmod: 2019-07-21T13:29:29+02:00
# Change History:
# ---------------
#   - 2019-07-21: added sudo/root check
#   - 2019-07-20: printf corrections
#   - 2019-07-18: created, moved from personal-setup.sh

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

printf "%b Installing network packages...\n" "${STR_INFO}"

##########################################
# Official packages
##########################################
printf "%b Installing official packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed wireshark-cli wireshark-qt
sudo pacman -S --noconfirm --needed tcpdump
sudo pacman -S --noconfirm --needed netcat
sudo pacman -S --noconfirm --needed nmap
sudo pacman -S --noconfirm --needed net-snmp
sudo pacman -S --noconfirm --needed filezilla
sudo pacman -S --noconfirm --needed dnsutils

##########################################
# AUR packages
##########################################
# printf "${STR_INFO} Installing AUR packages...\n"

printf "%b Done installing network packages.\n" "${STR_INFO}"
exit 0
