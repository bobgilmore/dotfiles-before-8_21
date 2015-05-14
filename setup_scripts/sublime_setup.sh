#!/bin/bash

# Set up Sublime Text 3

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

if [ "$(uname)" = 'Darwin' ]; then
  echo "Sublime Text..."

  # Create the "subl" symlink to open Sublime Text (3) from the cli
  if [ -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]
  then
    mkdir -p "$BIN_DIRECTORY"
    link_if_necessary "/Applications/Sublime Text.app/Contents/SharedSupport/bin" "$BIN_DIRECTORY" "subl"
  else
    echo "Sublime Text (version 3) not installed, skipping subl setup."
  fi

  # Sublime Text preferences etc. to be shared between multiple machines.

  # These files are constantly changing and shouldn't be checked in.
  # Store them in Dropbox, and make all machines point to the Dropbox copies.
  # See https://sublime.wbond.net/docs/syncing#dropbox-osx
  if [ ! -d "$DROPBOX_DIRECTORY/$LIB_SUBLIME_3/Packages" ]
  then
    mkdir -p "$DROPBOX_DIRECTORY/$LIB_SUBLIME_3/Packages"
  fi
  if [ ! -d "$HOME/$LIB_SUBLIME_3" ]
  then
    mkdir -p "$HOME/$LIB_SUBLIME_3"
  fi
  echo "Symlinking Sublime Text 3 in ~/Library/Application Support/"
  link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME_3" "$HOME/$LIB_SUBLIME_3" "Packages"
  link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME_3" "$HOME/$LIB_SUBLIME_3" "Installed Packages"
  link_if_necessary "$DOTFILE_DIRECTORY" "$HOME/$LIB_SUBLIME_3/Packages/User" "Preferences.sublime-settings"

  echo "...Sublime Text done."
else
  echo "Skipping Sublime Text setup on non-Mac. To silence this message, edit sublime_setup.sh."
fi
