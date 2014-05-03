#!/bin/bash

# Set up posix apps and scripts

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Symlinking local helper apps in ~/bin"
mkdir -p "$BIN_DIRECTORY"

echo "Symlinking helper scripts in ~/scripts"
mkdir -p "$SCRIPT_DIRECTORY"
for f in $DOTFILE_DIRECTORY/scripts/*; do
  link_if_necessary "$DOTFILE_DIRECTORY/scripts" "$SCRIPT_DIRECTORY" $(basename $f)
done