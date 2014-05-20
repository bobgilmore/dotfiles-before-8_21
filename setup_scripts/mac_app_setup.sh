#!/bin/bash

# Set up for "full-blown" Mac-specific applications

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

# Perform operations that only make sense on a Mac...
if [ $(uname) = 'Darwin' ]
then
  
  # Install Brett Terpstra's na script - https://github.com/ttscoff/na
  
  NA_DIR="$DOTFILE_DIRECTORY/na"
  if [ -d "$NA_DIR" ]; then
    echo "Updating NA script for TaskPaper.  See http://brettterpstra.com/projects/na/"
    cd $NA_DIR && git pull
  else
    # Cloning to $NA_DIR
    echo "Installing NA script for TaskPaper into $NA_DIR.  See http://brettterpstra.com/projects/na/"
    git clone https://github.com/ttscoff/na.git $NA_DIR
  fi
  cd $DOTFILE_DIRECTORY
  if [ -d "$NA_DIR" ]
  then
    link_if_necessary "$NA_DIR" "$ALIASES_DIRECTORY" "na.sh"
  else
    echo "Error: $NA_DIR not found."
  fi
  
  if [ ! -d "/Applications/TaskPaper.app" ]
  then
    echo "------ TODO ------"
    echo "You should install TaskPaper - it's great."
    echo "---- END TODO ----"
  fi

  echo "------ TODO ------"
  if [ -d "/Applications/KeyRemap4MacBook.app/" ]
  then
    mkdir -m 755 -p "$HOME/Library/Application Support/KeyRemap4MacBook/"
    link_if_necessary "$DOTFILE_DIRECTORY" "$HOME/Library/Application Support/KeyRemap4MacBook" "private.xml"
    /Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli reloadxml
    echo "When installation is complete,"
    echo "Run KeyRemap4MacBook, open its Preference pane, go to the Change Key panel, and check all of the check boxes at the top of the remapping list."
    echo "This will enable Hyper key.  See http://brettterpstra.com/2012/12/08/a-useful-caps-lock-key/ for more on implementing it." 
  else
    echo "You should install KeyRemap4MacBook - it's awesome!  Then run this setup script again."
  fi
  echo "---- END TODO ----"
fi
