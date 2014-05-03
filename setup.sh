#!/bin/bash

# Load env vars and functions
source "$(pwd)/setup_utils.sh"

./dropbox_setup.sh
./homebrew_setup.sh
./dotfile_setup.sh
./posix_app_setup.sh
./sublime_setup.sh
./git_setup.sh
./vim_setup.sh
./ruby_setup.sh
# Mac-specific code
if [ $(uname) = 'Darwin' ]; then 
  ./mac_app_setup.sh
  ./.osx
fi

# CriticMarkup no longer installed.
#./criticmarkup_setup.sh
