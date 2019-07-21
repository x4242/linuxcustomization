#!/usr/bin/env bash

# Description:
# ------------
# link/copy/whatever dotfiles
#
# lastmod: 2019-07-20T21:41:02+02:00
# Change History:
# ---------------
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
printf "\n# load custom aliases\nif [ -f ~/.bash_aliases ]; then\n  . ~/.bash_aliases\nfi\n" >> ~/.bashrc
ln -sf "$(pwd)"/dotfiles/bash_aliases ~/.bash_aliases
