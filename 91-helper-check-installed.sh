#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Check if a program is installed. If not ask to install.
#
# Takes the programs's name as argument and checks using 'command -v'. If return
# value is not 0, 'pacman' is called with the argument passed if answered to
# install.
#
# ------------------------------------------------------------------------------
# License
# ------------------------------------------------------------------------------
# Copyright (C) 2020 0x4242
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful,but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <https://www.gnu.org/licenses/>.
#
# ------------------------------------------------------------------------------
# Social
# ------------------------------------------------------------------------------
#              __           __ __       ___    __ __       ___
#            /'__`\        /\ \\ \    /'___`\ /\ \\ \    /'___`\
#           /\ \/\ \  __  _\ \ \\ \  /\_\ /\ \\ \ \\ \  /\_\ /\ \
#           \ \ \ \ \/\ \/'\\ \ \\ \_\/_/// /__\ \ \\ \_\/_/// /__
#            \ \ \_\ \/>  </ \ \__ ,__\ // /_\ \\ \__ ,__\ // /_\ \
#             \ \____//\_/\_\ \/_/\_\_//\______/ \/_/\_\_//\______/
#              \/___/ \//\/_/    \/_/  \/_____/     \/_/  \/_____/
#
#     Web: http://0x4242.net | Twitter: @0x4242 <https://twitter.com/0x4242>
#                 GitHub: x4242 <https://github.com/x4242>
#
# ------------------------------------------------------------------------------
# Change History
# ------------------------------------------------------------------------------
# lastmod: 2020-03-26T14:36:53+01:00
# changelog:
#   - 2020-03-26: changed to header to std-sh-template, made POSIX-compliant
#   - 2019-07-21: created

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

printf "%b Checking if '%b' is installed...\n" "${STR_INFO}" "$1"
command -v $1 > /dev/null
if [ $? -eq 0 ]; then
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
