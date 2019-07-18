#!/usr/bin/env bash
#
# description: tbd
# lastmod: 2019-07-18T10:31:31+02:00
# change history:
#  - 2019-07-18: created

# String definitions for colored printf output
# [ ERROR ] in red
# [ INFO  ] in green
# [ INPUT ] in yellow
STR_ERROR="[ \e[31mERROR\e[0m ]"
STR_INFO="[ \e[32mINFO\e[0m  ]"
STR_INPUT="[ \e[1;33mINPUT\e[0m ]"

printf "%s Installing virtualization packages...\n" "${STR_INFO}"

# qemu
# libvirt
# virt-manager

# systemctl enable libtvrt service
