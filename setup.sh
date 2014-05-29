#!/bin/bash

./setup_scripts/dropbox_setup.sh
./setup_scripts/homebrew_setup.sh
./setup_scripts/dotfile_setup.sh
./setup_scripts/posix_app_setup.sh
./setup_scripts/sublime_setup.sh
./setup_scripts/git_setup.sh
./setup_scripts/vim_setup.sh
# Mac-specific code
if [ $(uname) == 'Darwin' ]; then 
  ./setup_scripts/mac_app_setup.sh
  ./setup_scripts/osx.sh
fi

# CriticMarkup no longer installed.
#./criticmarkup_setup.sh
