#!/bin/bash

# Set up posix apps and scripts

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Symlinking local helper apps in ~/bin"
mkdir -p "$BIN_DIRECTORY"

echo "Symlinking helper scripts in ~/aliases"
mkdir -p "$ALIASES_DIRECTORY"
for f in $DOTFILE_DIRECTORY/aliases/*; do
  link_if_necessary "$DOTFILE_DIRECTORY/aliases" "$ALIASES_DIRECTORY" $(basename $f)
done

echo "Symlinking helper scripts in ~/scripts"
mkdir -p "$SCRIPTS_DIRECTORY"
for f in $DOTFILE_DIRECTORY/scripts/*; do
  link_if_necessary "$DOTFILE_DIRECTORY/scripts" "$SCRIPTS_DIRECTORY" $(basename $f)
done
