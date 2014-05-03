#!/bin/bash

# Set up Homebrew and packages

# Load env vars and functions
source "$(pwd)/setup_utils.sh"

if [ $(uname) = 'Darwin' ]; then
  if [ ! -f /usr/local/bin/brew ]; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  fi
  Echo "Installing Homebrew formulae"
  brew bundle
fi