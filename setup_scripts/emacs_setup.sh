#!/bin/bash

# Set up Emacs configuration

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Emacs..."
if [ ! -d "$DROPBOX_DIRECTORY/emacs" ]; then
  mkdir -p "$DROPBOX_DIRECTORY/emacs/.emacs.d"
fi
echo "Symlinking $HOME/.emacs.d"
link_if_necessary "$DROPBOX_DIRECTORY/emacs" "$HOME" ".emacs.d"

echo "... Emacs done"
