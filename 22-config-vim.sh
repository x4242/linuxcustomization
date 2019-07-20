#!/usr/bin/env bash

# Description:
# ------------
# Linking .vimrc, installing plugin manager and color schemes. Plugins to be
# installed are configures within .vimrc.
#
# lastmod: 2019-07-20T11:11:14+02:00
# Change History:
# ---------------
# - 2019-07-20:
#   - added checks if .vimrc, Vundle and color schemes already exist
#   - changed output colors to light green/red/yellow

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

# link .vimrc
if [[ -f ~/.vimrc ]]; then
  printf "%b ~/.vimrc already exists. Backup and replace (y/n)? " "${STR_INPUT}"
  read -r yes_no
  case $yes_no in
    [Yy]* )
      printf "%b Existing ~/.vimrc moved to ~/.vimrc.bak. If it already existed it was overwritten. New ./~vimrc linked.\n" "${STR_INFO}"
      mv -f ~/.vimrc ~/.vimrc.bak
      ln -sf "$(pwd)"/dotfiles/vimrc ~/.vimrc
      ;;
  esac
else
  ln -s "$(pwd)"/dotfiles/vimrc ~/.vimrc
fi


# vundle plugin manmager
if [[ -d ~/.vim/bundle/Vundle.vim ]]; then
  printf "%b ~/.vim/bundle/Vundle.vim already exists. Skipping download.\n" "${STR_ERROR}" >&2
else
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi


# vim-one color scheme from https://github.com/rakr/vim-one
if [[ ! -d ~/.vim/colors ]]; then
  mkdir -p ~/.vim/colors
  wget https://raw.githubusercontent.com/rakr/vim-one/master/colors/one.vim -P ~/.vim/colors/
elif [[ ! -f ~/.vim/colors/one.vim ]]; then
  wget https://raw.githubusercontent.com/rakr/vim-one/master/colors/one.vim -P ~/.vim/colors/
else
  printf "%b ~/.vim/colors/one.vim already exists. Skipping download.\n" "${STR_ERROR}" >&2
fi

# install plugins configure in .vimrc
vim +PluginInstall +qall
