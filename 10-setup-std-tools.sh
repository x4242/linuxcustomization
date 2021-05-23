#!/bin/sh
#
# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# Install and config tools for daily/std use + personalization.
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
# lastmod: 2021-05-23T19:15:12+02:00
# changelog:
#   - 2021-05-21: added signal, telegram, thunderbird
#   - 2020-03-26:
#     - added installation of 'urxvt-unicode'
#     - changed header to std-sh-template
#     - make POSIX-compliant
#   - 2020-01-23: added docker, docker-compose and hadolinter
#   - 2019-09-08:
#     - added pacman/yay db sync prior to install
#     - added clamav, firewalld
#   - 2019-07-27: added hunspell dictionaries fpr spell checking
#   - 2019-07-21: added check if yay is installed and root/sudo
#   - 2019-07-20:
#     - added flameshot
#     - printf corrections
#   - 2019-07-18: added shellcheck
#   - 2019-07-18: created, moved from personal-setup.sh

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

printf "%b Installing standard packages...\n" "${STR_INFO}"

# ------------------------------------------------------------------------------
# Install common tools
# ------------------------------------------------------------------------------
printf "%b Installing common packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed urxvt-unicode
sudo pacman -S --noconfirm --needed grc
sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed plank
sudo pacman -S --noconfirm --needed hunspell-de
sudo pacman -S --noconfirm --needed hunspell-en_US

# ------------------------------------------------------------------------------
# Install misc tools
# ------------------------------------------------------------------------------
printf "%b Installing misc. packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed nextcloud-client
sudo pacman -S --noconfirm --needed keepassxc
sudo pacman -S --noconfirm --needed pandoc
sudo pacman -S --noconfirm --needed flameshot

# ------------------------------------------------------------------------------
# Install dev tools
# ------------------------------------------------------------------------------
printf "%b Installing development packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed atom
sudo pacman -S --noconfirm --needed docker
sudo pacman -S --noconfirm --needed docker-compose
sudo pacman -S --noconfirm --needed hugo
sudo pacman -S --noconfirm --needed php
sudo pacman -S --noconfirm --needed python-pylint
sudo pacman -S --noconfirm --needed shellcheck

# ------------------------------------------------------------------------------
# Install com tools
# ------------------------------------------------------------------------------
printf "%b Installing communication packages...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed telegram-desktop
sudo pacman -S --noconfirm --needed signal-desktop
sudo pacman -S --noconfirm --needed thunderbird

# pip for python2
sudo python2 -m ensurepip

# enable docker
sudo systemctl enable docker.service

# ------------------------------------------------------------------------------
# Install security tools
# ------------------------------------------------------------------------------
printf "%b Installing security packages...\n" "${STR_INFO}"
# install, enable and update clamav
sudo pacman -S --noconfirm --needed clamav
sudo systemctl enable clamav-daemon.service
sudo systemctl start clamav-daemon.service
sudo freshclam
# install, enable firewalld
sudo pacman -S --noconfirm --needed firewalld
sudo systemctl enable firewalld.service
sudo systemctl start firewalld.service

# ------------------------------------------------------------------------------
# Install AUR packages
# ------------------------------------------------------------------------------
if [ "$(./91-helper-check-installed.sh yay)" -eq 0 ]; then
  yay -Sy
  printf "%b Installing AUR customization packages...\n" "${STR_INFO}"
  yay -S --noconfirm equilux-theme
  yay -S --noconfirm hadolinter-bin
  yay -S --noconfirm ttf-roboto-mono
else
  printf "%b Couldn't install AUR packages as 'yay' is not installed.\n" "${STR_ERROR}" >&2
  exit 1
fi

printf "%b Done installing standard packages.\n" "${STR_INFO}"
exit 0
