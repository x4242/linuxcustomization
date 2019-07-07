#!/usr/bin/env bash

# lastmod: 2019-07-07T01:01:21+02:00

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

# copy config files
cp ./dotfiles/atom/config.cson ~/.atom/config.cson
cp ./dotfiles/atom/keymap.cson ~/.atom/keymap.cson
