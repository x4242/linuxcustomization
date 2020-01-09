#!/usr/bin/env bash

# Description:
# ------------
# Remove orphans, clean pacman and yay caches.
#
# lastmod: 2020-01-04T13:10:01+01:00
# Change History:
# ---------------
#   - 2020-01-04: corrected orphan removal (deleted "")
#   - 2019-07-21: created from 00-inital-manjaro-setup.sh

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

printf "%b Cleaning up...\n" "${STR_INFO}"

##########################################
# Remove orphans
##########################################
printf "%b Removing orphans if any...\n" "${STR_INFO}"
sudo pacman -Rscn --noconfirm $(pacman -Qdtq)

##########################################
# Clean pacman and yay caches
##########################################
printf "%b Cleaning caches...\n" "${STR_INFO}"
sudo pacman -Scc --noconfirm
bash ./91-helper-check-installed.sh yay
if [[ $? == 0 ]]; then
  yay -Sc --noconfirm
  sudo yay -Sc --noconfirm
fi

printf "%b Cleanup done.\n" "${STR_INFO}"
exit 0
