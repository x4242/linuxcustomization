#!/usr/bin/env bash
#
# description: initial config and installation of newly installed Manjaro
# lastmod: 2019-07-18T10:49:27+02:00
# change history:
#   - 2019-07-18: moved install/custom. sections to own scripts

# String definitions for colored printf output
# [ ERROR ] in red
# [ INFO  ] in green
# [ INPUT ] in yellow
STR_ERROR="[ \e[31mERROR\e[0m ]"
STR_INFO="[ \e[32mINFO\e[0m  ]"
STR_INPUT="[ \e[1;33mINPUT\e[0m ]"

##########################################
# Check if root / sudo
##########################################
if [ "$EUID" -eq 0 ]; then
  printf "%s Do not run with sudo / as root.\n" "${STR_ERROR}" >&2
  exit 1
fi

# enable multithread xz for makepkg
sudo sed -i "s/xz -c -z -/xz -c -z - --threads=0/g" /etc/makepkg.conf

##########################################
# Remove unwanted packages from Manjaro
##########################################
printf "%s Removing unwanted pakages from Manjaro installation...\n" "${STR_INFO}"
sudo pacman -Rscn --noconfirm steam-manjaro
sudo pacman -Rscn --noconfirm ms-office-online
sudo pacman -Rscn --noconfirm pidgin
sudo pacman -Rscn --noconfirm hplip
sudo pacman -Rscn --noconfirm xfburn
sudo pacman -Rscn --noconfirm hexchat

##########################################
# Update system
##########################################
printf "%s Upgrading packages...\n" "${STR_INFO}"
sudo pacman -Syyu --noconfirm

##########################################
# Check if running in VM
# ----------------------------------------
# - installation of VBoxGuestUtils requires user interaction to install correct
#   headers -> therefore no '--noconfirm'
# - other VMs tbd?
##########################################
if [[ $(command -v systemd-detect-virt 2>/dev/null) ]]; then
  printf "%s Checking if system is running in VM...\n" "${STR_INFO}"
  # if VirtualBox
  virtual_env=$(systemd-detect-virt)
  if [[ "${virtual_env}" == "oracle" ]]; then
    printf "%s System seems to run in Oracle VirtualBox, install VirtualBox Guest Additions (y/n)? " "${STR_INPUT}"
    read -r yes_no
    case $yes_no in
      [Yy]* ) sudo pacman -S --needed virtualbox-guest-utils
    esac
  #if VMware
  elif [[ "${virtual_env}" == "vmware" ]]; then
    printf "%s System seems to run in VMware environment, install Open-VM-Tools (y/n)? " "${STR_INPUT}"
    read -r yes_no
    case $yes_no in
      [Yy]* ) sudo pacman -S --needed open-vm-tools
    esac
  else
    printf "%s 'systemd-detect-virt' detected '%s'. Nothing defined to be installed for this environmentn\n" "${STR_ERROR}" "${virtual_env}" >&2
  fi
else
  printf "%s 'systemd-detect-virt' not found, can't check if running in VM.\n" "${STR_ERROR}" >&2
fi

##########################################
# Install yay for AUR packages
##########################################
printf "%s Installing yay...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed yay

##########################################
# Remove orphans
##########################################
printf "%s Removing orphans if any...\n" "${STR_INFO}"
sudo pacman -Rscn --noconfirm $(pacman -Qdtq)

##########################################
# Clean pacman and yay caches
##########################################
printf "%s Cleaning caches...\n" "${STR_INFO}"
sudo pacman -Scc --noconfirm
yay -Sc --noconfirm
sudo yay -Sc --noconfirm


printf "%s Done.\n" "${STR_INFO}"
exit 0
