#!/usr/bin/env bash
#
# link/copy/whatever dotfiles
# lastmod: 2019-07-07T15:57:53+02:00

# tmux config
ln -sf $(pwd)/dotfiles/tmux.conf ~/.tmux.conf

# bash config
printf "\n# load custom aliases\nif [ -f ~/.bash_aliases ]; then\n  . ~/.bash_aliases\nfi\n" >> ~/.bashrc
ln -sf $(pwd)/dotfiles/bash_aliases ~/.bash_aliases
