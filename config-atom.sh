#!/usr/bin/env bash
#
# install atom packeages and link config files
# lastmod: 2019-07-17T12:55:07+02:00

# insstall packages
apm install date
apm install highlight-selected
apm install atom-beautify
apm install wordcount
apm install language-markdown
apm install linter
apm install linter-ui-default
apm install intentions
apm install busy-signal
apm install linter-pylint
apm install autocomplete-python

# linking config files
if [[ ! -d  ~/.atom ]]; then mkdir ~/.atom; fi
ln -sf $(pwd)/dotfiles/atom/config.cson ~/.atom/config.cson
ln -sf $(pwd)/dotfiles/atom/keymap.cson ~/.atom/keymap.cson
