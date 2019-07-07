#!/usr/bin/env bash

# lastmod: 2019-07-07T00:11:59+02:00

cp ./dotfiles/vimrc ~/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# vim-one color scheme from https://github.com/rakr/vim-one
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/rakr/vim-one/master/colors/one.vim -P ~/.vim/colors/

vim +PluginInstall +qall
