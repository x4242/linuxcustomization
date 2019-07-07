#!/usr/bin/env bash
#
# lastmod: 2019-07-07T16:05:58+02:00

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
  printf "${STR_ERROR} Do not run with sudo / as root.\n" >&2
  exit 1
fi

# enable multithread xz for makepkg
sudo sed -i "s/xz -c -z -/xz -c -z - --threads=0/g" /etc/makepkg.conf

##########################################
# Remove unwanted packages from Manjaro
##########################################
printf "${STR_INFO} Removing unwanted pakages from Manjaro installation...\n"
sudo pacman -Rscn --noconfirm steam-manjaro
sudo pacman -Rscn --noconfirm ms-office-online
sudo pacman -Rscn --noconfirm pidgin
sudo pacman -Rscn --noconfirm hplip
sudo pacman -Rscn --noconfirm xfburn
sudo pacman -Rscn --noconfirm hexchat

##########################################
# Update system
##########################################
printf "${STR_INFO} Upgrading packages...\n"
sudo pacman -Syyu --noconfirm

##########################################
# Check if running in VM
# ----------------------------------------
# - installation of VBoxGuestUtils require user interaction to install correct
#   headers -> therefore no '--noconfirm'
# - other VMs tbd
##########################################
if [[ $(command -v systemd-detect-virt 2>/dev/null) ]]; then
  printf "${STR_INFO} Checking if system is running in VM...\n"
  if [[ "$(systemd-detect-virt)" == "oracle" ]]; then
    printf "${STR_INPUT} System seems to run in Oracle VirtualBox, install VirtualBox Guest Additions (y/n)? "
    read yes_no
    case $yes_no in
      [Yy]* ) sudo pacman -S --needed virtualbox-guest-utils
    esac
  fi
else
  printf "${STR_ERROR} 'systemd-detect-virt' not found, can't check if running in VM.\n" >&2
fi

##########################################
# Install common tools
##########################################
printf "${STR_INFO} Installing common packages...\n"
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed plank

##########################################
# Install network tools
##########################################
printf "${STR_INFO} Installing network packages...\n"
sudo pacman -S --noconfirm --needed wireshark-cli wireshark-qt
sudo pacman -S --noconfirm --needed tcpdump
sudo pacman -S --noconfirm --needed netcat
sudo pacman -S --noconfirm --needed nmap
sudo pacman -S --noconfirm --needed net-snmp
sudo pacman -S --noconfirm --needed filezilla

##########################################
# Install pentesting tools
##########################################
printf "${STR_INFO} Installing pentesting packages...\n"
sudo pacman -S --noconfirm --needed metasploit
sudo pacman -S --noconfirm --needed john
sudo pacman -S --noconfirm --needed hashcat
sudo pacman -S --noconfirm --needed sqlmap
sudo pacman -S --noconfirm --needed exploitdb
sudo pacman -S --noconfirm --needed wpscan

##########################################
# Install misc tools
##########################################
printf "${STR_INFO} Installing misc. packages...\n"
sudo pacman -S --noconfirm --needed nextcloud-client
sudo pacman -S --noconfirm --needed keepassxc
sudo pacman -S --noconfirm --needed pandoc

##########################################
# Install dev tools
##########################################
printf "${STR_INFO} Installing development packages...\n"
sudo pacman -S --noconfirm --needed atom
sudo pacman -S --noconfirm --needed hugo
sudo pacman -S --noconfirm --needed php
sudo pacman -S --noconfirm --needed python-pylint

##########################################
# Install yay for AUR packages
##########################################
printf "${STR_INFO} Installing yay...\n"
sudo pacman -S --noconfirm --needed yay

##########################################
# Install AUR pentesting tools
##########################################
printf "${STR_INFO} Installing AUR pentesting packages...\n"
yay -S --noconfirm burpsuite
yay -S --noconfirm gobuster-git
yay -S --noconfirm dirbuster
yay -S --noconfirm hash-identifier
yay -S --noconfirm seclists-git
yay -S --noconfirm rockyou
yay -S --noconfirm responder

##########################################
# Install AUR customizations
##########################################
printf "${STR_INFO} Installing AUR customization packages...\n"
yay -S --noconfirm equilux-theme
yay -S --noconfirm ttf-roboto-mono

##########################################
# Create directories and links
##########################################
printf "${STR_INFO} Creating links and directories...\n"
if [[ ! -d /usr/share/wordlists ]]; then sudo mkdir /usr/share/wordlists; fi
if [[ -d /usr/share/dirbuster ]]; then sudo ln -sf /usr/share/dirbuster /usr/share/wordlists/dirbuster; fi
if [[ -e /usr/share/dict/rockyou.txt ]]; then sudo ln -sf /usr/share/dict/rockyou.txt /usr/share/wordlists/rockyou.txt; fi

##########################################
# Remove orphans
##########################################
printf "${STR_INFO} Removing orphans if any...\n"
sudo pacman -Rscn --noconfirm $(pacman -Qdtq)

##########################################
# Clean pacman and yay caches
##########################################
printf "${STR_INFO} Cleaning caches...\n"
sudo pacman -Scc --noconfirm
yay -Sc --noconfirm
sudo yay -Sc --noconfirm

##########################################
# Firefox config
##########################################
printf "${STR_INFO} Configuring Firefox...\n"
bash ./config-firefox.sh

##########################################
# Atom config
##########################################
printf "${STR_INFO} Configuring Atom...\n"
bash ./config-atom.sh

##########################################
# xfce config
##########################################
printf "${STR_INFO} Configuring xfce4...\n"
bash ./config-xfce.sh

##########################################
# Configure vim
##########################################
printf "${STR_INFO} Configuring vim...\n"
bash ./config-vim.sh

##########################################
# Configure dotfiles
##########################################
printf "${STR_INFO} Configuring dotfiles...\n"
bash ./config-dotfiles.sh


printf "${STR_INFO} Done.\n"
exit 0
