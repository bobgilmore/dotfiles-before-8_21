#!/bin/bash

# Set up Homebrew and packages

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Homebrew..."
if [ "$(uname)" = 'Darwin' ]; then
  if [ ! -f /usr/local/bin/brew ]; then
    echo "Installing"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew update
  brew doctor
  brew upgrade --all

  Echo "Installing formulae"

  brew install ack
  brew install bash
  brew install bash-completion
  brew install boot2docker
  brew install beeftornado/rmtree/brew-rmtree
  brew install cask
  brew install coreutils
  brew install ctags
  brew install docker-compose
  brew install elixir
  # From http://www.emacswiki.org/emacs/EmacsForMacOS#toc16
  brew install --cocoa --srgb emacs
  brew install erlang
  brew install findutils
  brew install fish
  brew install ghostscript
  brew install git
  brew install gnu-sed
  brew install homebrew/dupes/grep
  brew install heroku-toolbelt
  brew install hh
  brew install hub
  brew install imagemagick
  brew install jbig2dec
  brew install jq
  brew install libidn
  brew install macvim
  brew install memcached
  brew install mercurial
  brew install homebrew/versions/mongodb26
  brew install multimarkdown
  brew install mysql
  brew install node
  brew install ossp-uuid
  brew install phantomjs
  brew install postgresql
  brew install python
  brew install qt
  brew install rabbitmq
  brew install rbenv
  brew install reattach-to-user-namespace
  brew install redis
  brew install ruby-build
  brew install the_silver_searcher
  brew install tig
  brew install tmux
  brew install tree
  brew install vim
  brew install watchman
  brew install webkit2png
  brew install wget

  brew tap homebrew/dupes
  brew install grep

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
