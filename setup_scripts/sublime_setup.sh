#!/bin/bash

# Set up Sublime Text - version 2 and 3

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Sublime..."
if [ $(uname) = 'Darwin' ]; then
  # Create the "subl" symlink to open Sublime Text (3) from the cli
  if [ -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]
  then
    mkdir -p "$BIN_DIRECTORY"
    link_if_necessary "/Applications/Sublime Text.app/Contents/SharedSupport/bin" "$BIN_DIRECTORY" "subl"
  else
    echo "Sublime Text (version 3) not installed, skipping subl setup."
  fi

  # Sublime Text preferences etc. to be shared between multiple machines.

  # These files are constantly-changing and shouldn't be checked in.
  # Store them in Dropbox, and make all machines point to the Dropbox copies.

  # Handle Sublime 2 Preferences and packages.
  if [ -d "$DROPBOX_DIRECTORY/$LIB_SUBLIME_2/Installed Packages" ]
  then
    echo "Symlinking Sublime Text 2 in ~/Library/Application Support/"
    link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME_2" "$HOME/$LIB_SUBLIME_2" "Installed Packages"
    link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME_2" "$HOME/$LIB_SUBLIME_2" "Packages"
    link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME_2" "$HOME/$LIB_SUBLIME_2" "Pristine Packages"
  else
    echo "Can't find $DROPBOX_DIRECTORY/$LIB_SUBLIME_2/Installed Packages/ for symlinks."
  fi

  # Handle Sublime 3 Preferences and packages.
  # Many fewer files are shared in Sublime 3 since it, itself, loads new packages as necessary.
  # See https://sublime.wbond.net/docs/syncing#dropbox-osx
  if [ -d "$DROPBOX_DIRECTORY/$LIB_SUBLIME_3/Packages/User" ]
  then
    echo "Symlinking Sublime Text 3 in ~/Library/Application Support/"
    link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME_3/Packages" "$HOME/$LIB_SUBLIME_3/Packages" "User"
  else
    echo "Can't find $DROPBOX_DIRECTORY/$LIB_SUBLIME_3/Packages/User for symlinks."
  fi
else
  echo "Skipping Sublime Text setup on non-Mac. To fix this, edit sublime_setup.sh."
fi
echo "...Sublime done."
