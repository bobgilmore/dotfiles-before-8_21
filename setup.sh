#!/bin/bash

./setup_scripts/dropbox_setup.sh
./setup_scripts/homebrew_setup.sh
./setup_scripts/npm_setup.sh
./setup_scripts/dotfile_setup.sh
./setup_scripts/posix_app_setup.sh
./setup_scripts/git_setup.sh
./setup_scripts/vim_setup.sh
./setup_scripts/emacs_setup.sh
# Mac-specific code
if [ "$(uname)" == "Darwin" ]; then
    ./setup_scripts/osx.sh
    ./setup_scripts/xcode_setup.sh
fi
