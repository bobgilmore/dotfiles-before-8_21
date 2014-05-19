#!/bin/bash

# Set up Vim configuration

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Vim..."
# From https://github.com/tpope/vim-pathogen
echo -e "Installing pathogen into $HOME_VIM/autoload"
mkdir -p $HOME_VIM/autoload
curl -Sso $HOME_VIM/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

if [ ! -d "$DROPBOX_DIRECTORY/vim" ]; then
  mkdir -p "$DROPBOX_DIRECTORY/vim/bundle"
fi
echo "Symlinking bundles in $HOME_VIM/bundle"
link_if_necessary "$DROPBOX_DIRECTORY/vim" "$HOME_VIM" "bundle"

echo "... Vim done"