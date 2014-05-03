#!/bin/bash

# Set up posix apps and scripts

# Load env vars and functions
source "$(pwd)/setup_utils.sh"

if [ ! -d "$HOME/Dropbox/" ]; then
  echo "------ TODO ------"
  echo "These setup scripts rely on Dropbox to share preferences between computers."
  echo "You should *really* get Dropbox set up on this machine."
  echo "If you want to work with another service, i.e. Google Drive, go for it!"
  echo "---- END TODO ----"
  exit 0
fi

if [ ! -d "$DROPBOX_DIRECTORY" ]; then
  mkdir -p "$DROPBOX_DIRECTORY"
  echo "Creating shared preference directory $DROPBOX_DIRECTORY"
fi

if [ -d "$DROPBOX_DIRECTORY" ]; then
echo "This directory exists for use by https://github.com/bobgilmore/dotfiles

It contains directories and files that apps (such as Sublime Text and Vim)
constantly modify, and which therefore aren't really suited for
checking in to git.

This README.md was created by the github project's setup.sh script for
informational purposes.

See the github repo for more information.
" > "$DROPBOX_DIRECTORY/README.md"
fi