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
  brew update
  brew doctor
  brew upgrade

  Echo "Installing formulae"

  brew install ack
  brew install bash
  brew install bash-completion
  brew install coreutils
  brew install ctags
  brew install findutils
  brew install fish
  brew install ghostscript
  brew install git
  brew install gitsh
  brew install gnu-sed
  brew install go
  brew install grep
  brew install heroku-toolbelt
  brew install hub
  brew install imagemagick
  brew install jq
  brew install libidn
  brew install macvim
  brew install memcached
  brew install mercurial
  brew install mongodb
  brew install multimarkdown
  brew install mysql
  brew install node
  brew install phantomjs
  brew install postgresql
  brew install python
  brew install qt
  brew install rabbitmq
  brew install rbenv
  brew install reattach-to-user-namespace
  brew install redis
  brew install ruby-build
  brew install sqlite
  brew install the_silver_searcher
  brew install tig
  brew install tmux
  brew install tree
  brew install vim
  brew install webkit2png
  brew install wget

  brew tap homebrew/dupes
  brew install grep
  brew tap thoughtbot/formulae
  brew install gitsh

  brew cleanup
  brew linkapps

  # Homebrew core team broke brew services, so disable for now and revisit if it becomes necessary.
  # https://github.com/Homebrew/homebrew/issues/28657
  #brew services restart mysql
  #brew services restart redis

  # Ask for the administrator password upfront
  echo "Changes require admin access - supply admin password if prompted:"
  sudo -v

  # Add fish and bash to the list of acceptable shells.
  echo "Adding fish shell"
  grep -q '/usr/local/bin/fish' /etc/shells || echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
  echo "Adding bash shell"
  grep -q '/usr/local/bin/bash' /etc/shells || echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
fi
echo "...Homebrew done."
