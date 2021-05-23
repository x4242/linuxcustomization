#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Remove orphans and clean pacman and yay (if installed) caches.
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
# lastmod: 2020-11-14T12:43:43+01:00
# changelog:
#   - 2020-11-14:
#       - added root/sudo check
#       - header update to template
#       - change to make POSIX compliant -> fix POSIX warnings
#   - 2020-01-04: corrected orphan removal (deleted "")
#   - 2019-07-21: created from 00-inital-manjaro-setup.sh

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
#STR_INPUT="[ \e[93mINPUT\e[0m ]"


# ------------------------------------------------------------------------------
# Check if root / sudo
# ------------------------------------------------------------------------------
if [ "$(id -u)" -eq 0 ]; then
  printf "%b Do not run with sudo / as root.\n" "${STR_ERROR}" >&2
  exit 1
fi

printf "%b Cleaning up...\n" "${STR_INFO}"

# ------------------------------------------------------------------------------
# Remove orphans
# ------------------------------------------------------------------------------
printf "%b Removing orphans if any...\n" "${STR_INFO}"
sudo pacman -Rscn --noconfirm "$(pacman -Qdtq)"

# ------------------------------------------------------------------------------
# Clean pacman and yay caches
# ------------------------------------------------------------------------------
printf "%b Cleaning caches...\n" "${STR_INFO}"
sudo pacman -Scc --noconfirm
bash ./91-helper-check-installed.sh yay
if [ $? -eq 0 ]; then
  yay -Sc --noconfirm
  sudo yay -Sc --noconfirm
fi

printf "%b Cleanup done.\n" "${STR_INFO}"
exit 0
