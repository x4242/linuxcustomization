#!/usr/bin/env bash
#
# link config file, install vundle plugin manager and customize colores
# lastmod: 2019-07-10T12:47:43+02:00

# link .vimrc
ln -sf $(pwd)/dotfiles/vimrc ~/.vimrc

# vundle pligin manmager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# vim-one color scheme from https://github.com/rakr/vim-one
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/rakr/vim-one/master/colors/one.vim -P ~/.vim/colors/

# install plugins configure in .vimrc
vim +PluginInstall +qall
