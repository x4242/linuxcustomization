#!/usr/bin/env bash

# Description:
# ------------
# link/copy/whatever dotfiles
#
# lastmod: 2019-07-28T10:09:21+02:00
# Change History:
# ---------------
#   - 2019-07-28: added grc aliases
#   - 2019-07-20: printf corrections

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

# tmux config
ln -sf "$(pwd)"/dotfiles/tmux.conf ~/.tmux.conf

# bash config
printf "\n# load custom aliases\n[[ -s ~/.bash_aliases ]] && . ~/.bash_aliases\n" >> ~/.bashrc
printf "\n# load grc aliases\n[[ -s '/etc/profile.d/grc.bashrc' ]] && source /etc/profile.d/grc.bashrc\n" >> ~/.bashrc
ln -sf "$(pwd)"/dotfiles/bash_aliases ~/.bash_aliases
