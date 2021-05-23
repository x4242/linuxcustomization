#!/usr/bin/env bash

# Description:
# ------------
# Install Atom packeages and link config files.
#
# lastmod: 2020-03-22T12:15:39+01:00
# Change History:
# ---------------
# - 2020-03-22:
#   - added linking of style.less
#   - printf typo corrections
#   - +markdown-preview-plus
# - 2020-01-23: added packages language-docker, linter-hadolint
# - 2019-07-27: added package 'linter-spell'
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
               language-docker
               language-markdown
               linter
               linter-hadolinter
               linter-pylint
               linter-shellcheck
               linter-spell
               linter-ui-default
               markdown-preview-plus
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
      printf "%b Existing ~/.atom/config.cson moved to ~/.atom/config.cson.bak. If it already existed it was overwritten. New ~/.atom/config.cson linked.\n" "${STR_INFO}"
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
      printf "%b Existing ~/.atom/keymap.cson moved to ~/.atom/keymap.cson.bak. If it already existed it was overwritten. New~/.atom/keymap.cson linked.\n" "${STR_INFO}"
      mv -f ~/.atom/keymap.cson ~/.atom/keymap.cson.bak
      ln -s "$(pwd)"/dotfiles/atom/keymap.cson ~/.atom/keymap.cson
      ;;
    *)
      printf "%b Nothing done for ~/.atom/keymap.cson.\n" "${STR_INFO}"
  esac
fi

# check if ~/.atom/styles.less exists, if so ask what to do
if [[ ! -f ~/.atom/styles.less ]]; then
  ln -s "$(pwd)"/dotfiles/atom/styles.less ~/.atom/styles.less
else
  printf "%b ~/.atom/styles.less exists already. Backup and overwrite (y/n)? " "${STR_INPUT}"
  read -r yes_no
  case $yes_no in
    [Yy]* )
      printf "%b Existing ~/.atom/styles.less moved to ~/.atom/styles.less.bak. If it already existed it was overwritten. New ~/.atom/styles.less linked.\n" "${STR_INFO}"
      mv -f ~/.atom/styles.less ~/.atom/styles.less.bak
      ln -s "$(pwd)"/dotfiles/atom/styles.less ~/.atom/styles.less
      ;;
    *)
      printf "%b Nothing done for ~/.atom/keymap.cson.\n" "${STR_INFO}"
  esac
fi
