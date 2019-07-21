#!/usr/bin/env bash

# Description:
# ------------
# Check if 'yay' is installed. If not ask to install.
#
# lastmod: 2019-07-21T13:21:35+02:00
# Change History:
# ---------------
#   - 2019-07-21: created

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

printf "%b Checking if '%b' is installed...\n" "${STR_INFO}" "$1"
which $1
if [[ $? == 0 ]]; then
  printf "%b '%b' found. -> OK\n" "${STR_INFO}" "$1"
  exit 0
else
  printf "%b '%b' not found, but needed.\n" "${STR_ERROR}" "$1" >&2
  printf "%b Install '%b' (y/n)? " "${STR_INPUT}" "$1"
  read -r yes_no
  case $yes_no in
    [Yy]* )
      sudo pacman -S --needed $1
      ;;
    *)
      printf "%b '%b' not installed. -> NOK\n" "${STR_ERROR}" "$1" >&2
      exit 1
      ;;
  esac
fi
