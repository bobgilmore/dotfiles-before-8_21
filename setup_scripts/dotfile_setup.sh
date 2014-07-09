#!/bin/bash

# Set up dotfiles

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Symlinking dotfiles in ~"
for f in $DOTFILE_DIRECTORY/.* ; do
  base=$(basename $f)
  if [[ ($base != ".") && ($base != "..") && ($base != ".git") && ($base != ".config") ]]; then
    link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" $base
  fi
done

echo "Symlinking .config in ~"
mkdir -p "$HOME/.config"
for f in $DOTFILE_DIRECTORY/.config/* ; do
  base=$(basename $f)
  if [[ ($base != ".") && ($base != "..") ]]; then
    link_if_necessary "$DOTFILE_DIRECTORY/.config" "$HOME/.config" $base
  fi
done

