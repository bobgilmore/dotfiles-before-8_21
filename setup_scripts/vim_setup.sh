#!/bin/bash

# Set up Vim configuration

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

# From https://github.com/tpope/vim-pathogen
echo -e "Installing Vim pathogen into $HOME_VIM/autoload"
mkdir -p $HOME_VIM/autoload
curl -Sso $HOME_VIM/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

if [ -d "$DROPBOX_DIRECTORY/vim" ]; then
  echo "Symlinking Vim bundles in $HOME_VIM/bundle"
  link_if_necessary "$DROPBOX_DIRECTORY/vim" "$HOME_VIM" "bundle"
else
  if [ ! -d "$HOME_VIM/bundle" ]; then
    echo "Creating $HOME_VIM/bundle for Vim pathogen bundles"
    mkdir -p "$HOME_VIM/bundle"
  fi
fi