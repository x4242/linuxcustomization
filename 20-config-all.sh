#!/usr/bin/env bash
#
# description: run all config/perrsonalization scripts
# lastmod: 2019-07-18T10:51:17+02:00
# change history:
#  - 2019-07-18: created, moved from personal-setup.sh

# String definitions for colored printf output
# [ ERROR ] in red
# [ INFO  ] in green
# [ INPUT ] in yellow
STR_ERROR="[ \e[31mERROR\e[0m ]"
STR_INFO="[ \e[32mINFO\e[0m  ]"
STR_INPUT="[ \e[1;33mINPUT\e[0m ]"

##########################################
# Configure dotfiles
##########################################
printf "%s Configuring dotfiles...\n" "${STR_INFO}"
bash ./21-config-dotfiles.sh

##########################################
# Configure vim
##########################################
printf "%s Configuring vim...\n" "${STR_INFO}"
bash ./22-config-vim.sh

##########################################
# Atom config
##########################################
printf "%s Configuring Atom...\n" "${STR_INFO}"
bash ./23-config-atom.sh

##########################################
# Firefox config
##########################################
printf "%s Configuring Firefox...\n" "${STR_INFO}"
bash ./24-config-firefox.sh

##########################################
# xfce config
##########################################
printf "%s Configuring xfce4...\n" "${STR_INFO}"
bash ./25-config-xfce.sh
