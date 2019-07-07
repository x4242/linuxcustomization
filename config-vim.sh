#!/usr/bin/env bash
#
# link config file, install vundle plugin manager and customize colores
# lastmod: 2019-07-07T15:37:54+02:00

ln -sf $(pwd)/dotfiles/vimrc ~/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# vim-one color scheme from https://github.com/rakr/vim-one
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/rakr/vim-one/master/colors/one.vim -P ~/.vim/colors/

vim +PluginInstall +qall
