#!/bin/bash

# Set up dotfiles

# Load env vars and functions
source "$(pwd)/setup_utils.sh"

echo "Symlinking dotfiles in ~"
for f in $DOTFILE_DIRECTORY/.* ; do
  base=$(basename $f)
  if [[ ($base != ".") && ($base != "..") && ($base != ".git") ]]; then
    link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" $base
  fi
done