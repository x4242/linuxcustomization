#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Install and config tools for 3D printing and design.
#
# ------------------------------------------------------------------------------
# License
# ------------------------------------------------------------------------------
# Copyright (C) 2021 0x4242
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
# lastmod: 2021-05-23T19:06:32+02:00
#  - 2021-05-23:
#      - removed printrun and slic3r, freecad using pacman, added meshlab
#      - changed header to std-sh-template and made POSIX compliant
#  - 2020-01-19:
#    - out commented slic3r+dependencies
#    - changed printrun to printrun-git
#  - 2020-01-04: added missing slic3r dep.
#  - 2019-12-29: created

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

# sync databases
sudo pacman -Sy

printf "%b Installing 3d printing packages...\n" "${STR_INFO}"

# ------------------------------------------------------------------------------
# Official packages
# ------------------------------------------------------------------------------
printf "%b Installing official packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed cura
sudo pacman -S --noconfirm --needed blender
sudo pacman -S --noconfirm --needed openscad
sudo pacman -S --noconfirm --needed freecad

# ------------------------------------------------------------------------------
# Install AUR packages
# ------------------------------------------------------------------------------
bash ./91-helper-check-installed.sh yay
if [ "$(./91-helper-check-installed.sh yay)" -eq 0 ]; then
  yay -Sy
  printf "%b Installing AUR packages...\n" "${STR_INFO}"
  yay -S --noconfirm meshlab
else
  printf "%b Couldn't install AUR packages as 'yay' is not installed.\n" "${STR_ERROR}" >&2
  exit 1
fi

printf "%b Done installing 3d printing packages.\n" "${STR_INFO}"
exit 0
