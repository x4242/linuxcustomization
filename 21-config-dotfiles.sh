#!/usr/bin/env bash

# Description:
# ------------
# link/copy/whatever dotfiles
#
# lastmod: 2020-01-05T15:13:47+01:00
# Change History:
# ---------------
#   - 2020-01-05: moved .bashrc additions to new files (dotfiles/bashrc);
#                 gets appended to ~/.bashrc
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
cat "$(pwd)"/dotfiles/bashrc >> ~/.bashrc
ln -sf "$(pwd)"/dotfiles/bash_aliases ~/.bash_aliases
