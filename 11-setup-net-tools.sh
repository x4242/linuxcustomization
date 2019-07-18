#!/usr/bin/env bash
#
# description: tbd
# lastmod: 2019-07-18T10:16:21+02:00
# change history:
#   - 2019-07-18: created, moved from personal-setup.sh

# String definitions for colored printf output
# [ ERROR ] in red
# [ INFO  ] in green
# [ INPUT ] in yellow
STR_ERROR="[ \e[31mERROR\e[0m ]"
STR_INFO="[ \e[32mINFO\e[0m  ]"
STR_INPUT="[ \e[1;33mINPUT\e[0m ]"

printf "%s Installing network packages...\n" "${STR_INFO}"

##########################################
# Official packages
##########################################
printf "%s Installing official packages...\n" "${STR_INFO}"
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

printf "%s Done installing network packages.\n" "${STR_INFO}"
exit 0
