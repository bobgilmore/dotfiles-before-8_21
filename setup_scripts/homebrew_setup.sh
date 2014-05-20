#!/bin/bash

# Set up Homebrew and packages

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Homebrew..."
if [ $(uname) = 'Darwin' ]; then
  if [ ! -f /usr/local/bin/brew ]; then
    echo "Installing"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  fi
  brew doctor
  brew update
  Echo "Installing formulae"
  brew bundle "$DOTFILE_DIRECTORY/setup_scripts"

  # Ask for the administrator password upfront
  echo "Changes require admin access - supply admin password if prompted:"
  sudo -v

  echo "Adding fish shell"
  # Add fish and bash to the list of acceptable shells.
  grep -q '/usr/local/bin/fish' /etc/shells || echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
  grep -q '/usr/local/bin/bash' /etc/shells || echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
fi
echo "...Homebrew done."
