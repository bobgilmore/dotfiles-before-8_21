#!/bin/bash

# Set up posix apps and scripts

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Symlinking helper scripts in ~/aliases and ~/scripts"
mkdir -p "$ALIASES_DIRECTORY"
for f in $DOTFILE_DIRECTORY/aliases/*; do
  link_if_necessary "$DOTFILE_DIRECTORY/aliases" "$ALIASES_DIRECTORY" $(basename $f)
done

mkdir -p "$SCRIPTS_DIRECTORY"
for f in $DOTFILE_DIRECTORY/scripts/*; do
  link_if_necessary "$DOTFILE_DIRECTORY/scripts" "$SCRIPTS_DIRECTORY" $(basename $f)
done
