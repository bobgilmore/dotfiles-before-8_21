#!/bin/bash

# Set up for "full-blown" Mac-specific applications

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

# Perform operations that only make sense on a Mac...
if [ "$(uname)" = 'Darwin' ]
then

  # Install Brett Terpstra's na script - https://github.com/ttscoff/na

  NA_DIR="$DOTFILE_DIRECTORY/na"
  if [ -d "$NA_DIR" ]; then
    echo "Updating NA script for TaskPaper.  See http://brettterpstra.com/projects/na/"
    cd "$NA_DIR" && git pull
  else
    # Cloning to $NA_DIR
    echo "Installing NA script for TaskPaper into $NA_DIR.  See http://brettterpstra.com/projects/na/"
    git clone https://github.com/ttscoff/na.git "$NA_DIR"
  fi
  cd "$DOTFILE_DIRECTORY"
  if [ -d "$NA_DIR" ]
  then
    link_if_necessary "$NA_DIR" "$ALIASES_DIRECTORY" "na.sh"
  else
    echo "Error: $NA_DIR not found."
  fi

  if [ ! -d "/Applications/TaskPaper.app" ]
  then
    echo "------ TODO ------"
    echo "You should install TaskPaper."
    echo "---- END TODO ----"
  fi

  if [ -d "/Applications/Karabiner.app/" ]
  then
    if [ ! -L "$HOME/Library/Application Support/Karabiner/private.xml" ]
    then
      echo "------ TODO ------"
      mkdir -m 755 -p "$HOME/Library/Application Support/Karabiner/"
      link_if_necessary "$DOTFILE_DIRECTORY" "$HOME/Library/Application Support/Karabiner" "private.xml"
      /Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml
      echo "When installation is complete, run Karabiner, go to the Change Key panel, and check the boxes at the top of the remapping list."
      echo "This will enable the Hyper key.  See http://brettterpstra.com/2012/12/08/a-useful-caps-lock-key/ for more on implementing it."
      echo "---- END TODO ----"
    fi
  else
    echo "------ TODO ------"
    echo "You should install Karabiner, then run this setup script again."
    echo "---- END TODO ----"
  fi
fi
