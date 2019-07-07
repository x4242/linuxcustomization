#!/usr/bin/env bash
#
# install atom packeages and link config files
# lastmod: 2019-07-07T15:36:44+02:00

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

# linking config files
ln -s ./dotfiles/atom/config.cson ~/.atom/config.cson
ln -s ./dotfiles/atom/keymap.cson ~/.atom/keymap.cson
