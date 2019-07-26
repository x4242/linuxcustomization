#!/usr/bin/env bash

# Description:
# ------------
# Install Atom packeages and link config files.
#
# lastmod: 2019-07-20T13:49:21+02:00
# Change History:
# ---------------
# - 2019-07-24: added packages 'sort-lines', removed 'wordcount'
# - 2019-07-20:
#   - changed output colors to light green/red/yellow
#   - add checks if packages already installed and config files  exist
# - 2019-07-18: added linter-shellcheck

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

# packages to be installed
atom_packages=(
               atom-beautify
               autocomplete-python
               busy-signal
               date
               highlight-selected
               intentions
               language-markdown
               linter
               linter-pylint
               linter-shellcheck
               linter-ui-default
               sort-lines
              )

# check if packages are already installed, if so do nothing, otherwise install
for package in ${atom_packages[*]}; do
  if [[ -d  ~/.atom/packages/${package} ]] ; then
    printf "%b Atom package '${package}' installed already. Skipping.\n" "${STR_ERROR}" >&2
  else
    apm install ${package}
  fi
done

# check if directory ~/.atom exists, if not create it
if [[ ! -d  ~/.atom ]]; then
  mkdir ~/.atom;
fi

# check if ~/.atom/config.cson exists, if so ask what to do
if [[ ! -f ~/.atom/config.cson ]]; then
  ln -s "$(pwd)"/dotfiles/atom/config.cson ~/.atom/config.cson
else
  printf "%b ~/.atom/config.cson exists already. Backup and overwrite (y/n)? " "${STR_INPUT}"
  read -r yes_no
  case $yes_no in
    [Yy]* )
      printf "%b Existing ~/.atom/config.cson moved to ~/.atom/config.cson.bak. If it already existed it was overwritten. New ./~vimrc linked.\n" "${STR_INFO}"
      mv -f ~/.atom/config.cson ~/.atom/config.cson.bak
      ln -s "$(pwd)"/dotfiles/atom/config.cson ~/.atom/config.cson
      ;;
    *)
      printf "%b Nothing done for ~/.atom/config.cson.\n" "${STR_INFO}"
  esac
fi

# check if ~/.atom/keymap.cson exists, if so ask what to do
if [[ ! -f ~/.atom/keymap.cson ]]; then
  ln -s "$(pwd)"/dotfiles/atom/keymap.cson ~/.atom/keymap.cson
else
  printf "%b ~/.atom/keymap.cson exists already. Backup and overwrite (y/n)? " "${STR_INPUT}"
  read -r yes_no
  case $yes_no in
    [Yy]* )
      printf "%b Existing ~/.atom/keymap.cson moved to ~/.atom/keymap.cson.bak. If it already existed it was overwritten. New ./~vimrc linked.\n" "${STR_INFO}"
      mv -f ~/.atom/keymap.cson ~/.atom/keymap.cson.bak
      ln -s "$(pwd)"/dotfiles/atom/keymap.cson ~/.atom/keymap.cson
      ;;
    *)
      printf "%b Nothing done for ~/.atom/keymap.cson.\n" "${STR_INFO}"
  esac
fi
