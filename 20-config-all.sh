#!/usr/bin/env bash

# Description:
# ------------
# run all config/perrsonalization scripts
#
# lastmod: 2019-07-20T21:39:53+02:00
# Change History:
# ---------------
#   - 2019-07-20: prtinf corrections
#   - 2019-07-18: created, moved from personal-setup.sh

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

##########################################
# Configure dotfiles
##########################################
printf "%b Configuring dotfiles...\n" "${STR_INFO}"
bash ./21-config-dotfiles.sh

##########################################
# Configure vim
##########################################
printf "%b Configuring vim...\n" "${STR_INFO}"
bash ./22-config-vim.sh

##########################################
# Atom config
##########################################
printf "%b Configuring Atom...\n" "${STR_INFO}"
bash ./23-config-atom.sh

##########################################
# Firefox config
##########################################
printf "%b Configuring Firefox...\n" "${STR_INFO}"
bash ./24-config-firefox.sh

##########################################
# xfce config
##########################################
printf "%b Configuring xfce4...\n" "${STR_INFO}"
bash ./25-config-xfce.sh
