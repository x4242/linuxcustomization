#!/usr/bin/env bash

# Description:
# ------------
# Initial config and installation of newly installed Manjaro.
#
# lastmod: 2019-07-21T12:57:25+02:00
# Change History:
# ---------------
#   - 2019-07-21: moved yay/pacman cleanup to new script
#   - 2019-07-20: printf corrections, added qemu installations
#   - 2019-07-18: moved install/custom. sections to own scripts

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

##########################################
# Check if root / sudo
##########################################
if [ "$EUID" -eq 0 ]; then
  printf "%b Do not run with sudo / as root.\n" "${STR_ERROR}" >&2
  exit 1
fi

# enable multithread xz for makepkg
sudo sed -i "s/xz -c -z -/xz -c -z - --threads=0/g" /etc/makepkg.conf

##########################################
# Remove unwanted packages from Manjaro
##########################################
printf "%b Removing unwanted pakages from Manjaro installation...\n" "${STR_INFO}"
sudo pacman -Rscn --noconfirm steam-manjaro
sudo pacman -Rscn --noconfirm ms-office-online
sudo pacman -Rscn --noconfirm pidgin
sudo pacman -Rscn --noconfirm hplip
sudo pacman -Rscn --noconfirm xfburn
sudo pacman -Rscn --noconfirm hexchat

##########################################
# Update system
##########################################
printf "%b Upgrading packages...\n" "${STR_INFO}"
sudo pacman -Syyu --noconfirm

##########################################
# Check if running in VM
# ----------------------------------------
# - VirtualBox: installation of VBoxGuestUtils requires user interaction to
#   install correct headers -> therefore no '--noconfirm'
# - QEMU:
#   - assuptions that SPICE is used
#   - QXL driver tbd
# - VMware: not tested
##########################################
if [[ $(command -v systemd-detect-virt 2>/dev/null) ]]; then
  printf "%b Checking if system is running in VM...\n" "${STR_INFO}"
  # if VirtualBox
  virtual_env=$(systemd-detect-virt)
  if [[ "${virtual_env}" == "oracle" ]]; then
    printf "%b System seems to run in VirtualBox, install VirtualBox Guest Additions (y/n)? " "${STR_INPUT}"
    read -r yes_no
    case $yes_no in
      [Yy]* ) sudo pacman -S --needed virtualbox-guest-utils
    esac
  #if VMware
  elif [[ "${virtual_env}" == "vmware" ]]; then
    printf "%b System seems to run in VMware environment, install Open-VM-Tools (y/n)? " "${STR_INPUT}"
    read -r yes_no
    case $yes_no in
      [Yy]* ) sudo pacman -S --needed open-vm-tools
    esac
  # if QEMU
  elif [[ "${virtual_env}" == "qemu" ]]; then
    printf "%b System seems to run in QEMU environment, install QEMU Guest Agent and SPICE vdagent  (y/n)? " "${STR_INPUT}"
    read -r yes_no
    case $yes_no in
      [Yy]* )
        sudo pacman -S --needed qemu-guest-agent
        sudo systemctl enable qemu-ga
        sudo systemctl start qemu-ga
        sudo pacman -S --needed spice-vdagent
        sudo systemctl enable spice-vdagentd.service
        sudo systemctl start spice-vdagentd.service
        # TODO: QXL driver installation and Xorg config
        ;;
    esac
  else
    printf "%b 'systemd-detect-virt' detected '%b'. Nothing defined to be installed for this environmentn\n" "${STR_ERROR}" "${virtual_env}" >&2
  fi
else
  printf "%b 'systemd-detect-virt' not found, can't check if running in VM.\n" "${STR_ERROR}" >&2
fi

##########################################
# Install yay for AUR packages
##########################################
printf "%b Installing yay...\n" "${STR_INFO}"
sudo pacman -S --noconfirm --needed yay

##########################################
# Cleanup
##########################################
bash ./90-helper-cleanup.sh


printf "%b Done.\n" "${STR_INFO}"
exit 0
