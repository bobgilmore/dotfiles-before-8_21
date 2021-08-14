#!/bin/bash

# Set up Homebrew and packages

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Homebrew..."
if [ "$(uname)" = 'Darwin' ]; then
  if [ ! -f /usr/local/bin/brew ]; then
    echo "Installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
  brew update
  brew doctor
  brew upgrade

  Echo "Installing formulae"

  brew install ack
  brew install bartycrouch
  brew install bash
  brew install bash-completion
  brew install bat
  brew install cask
  brew install cocoapods
  brew install cocoapods-keys
  brew install coreutils
  brew install ctags
  # From http://www.emacswiki.org/emacs/EmacsForMacOS#toc16
  # brew install --cocoa --srgb emacs
  brew cask install emacs
  brew cask install fastlane
  brew install findutils
  brew install fish
  brew install ghostscript
  brew install git
  brew install gnu-sed
  brew install graphviz
  brew install grep
  brew install hh
  brew install hub
  brew install imagemagick
  brew install jbig2dec
  brew install jq
  brew install libidn
  brew install mint
  brew install mercurial
  brew install multimarkdown
  brew install node
  brew install perl
  brew install phantomjs
  brew install python
  brew install qt
  # From https://twitter.com/peterc/status/1088160191881928704
  brew cask install quicklook-json
  brew install rbenv
  brew install reattach-to-user-namespace
  brew install ruby-build
  brew install scons
  brew install shellcheck
  brew install swiftlint
  brew install the_silver_searcher
  brew install tag
  brew install tig
  brew install tmux
  brew install tree
  brew install vim
  brew install wget
  brew install xcodeproj
  brew install zsh

  #brew install boot2docker
  #brew install docker-compose
  #brew install elixir
  #brew install erlang
  #brew install gradle
  #brew install memcached
  #brew install mysql
  #brew install ossp-uuid
  #brew install postgresql
  #brew install rabbitmq
  #brew install redis
  #brew install sinatra
  #brew install thin
  #brew install watchman
  #brew install webkit2png

  brew cleanup

  # Homebrew core team broke brew services, so disable for now and revisit if it becomes necessary.
  # https://github.com/Homebrew/homebrew/issues/28657
  #brew services restart mysql
  #brew services restart redis

  # Ask for the administrator password upfront
  echo "Changes require admin access - supply admin password if prompted:"
  sudo -v

  # Add fish, and Homebrew's bash and zsh, to the list of acceptable shells.
  echo "Adding fish shell"
  grep -q '/usr/local/bin/fish' /etc/shells || echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
  echo "Adding bash shell"
  grep -q '/usr/local/bin/bash' /etc/shells || echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
  echo "Adding zsh shell"
  grep -q '/usr/local/bin/zsh' /etc/shells || echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells

  # Install powerline for use by vim.  This is done by pip, not homebrew, but I'm not bothering with
  # a pip_setup.sh yet.
  pip install powerline-status
fi
echo "...Homebrew done."
