#!/bin/bash

# Install CriticMarkup
# This script is no longer called from setup.sh, since the main motivation
# (installing it for Marked) is gone - CriticMarkup is built into Marked.

# Load env vars and functions
source "$(pwd)/setup_utils.sh"

# Install the CriticMarkup-toolkit.  
# See http://brettterpstra.com/2013/05/18/criticmarkup-in-marked-1-dot-4/ and 
# https://github.com/CriticMarkup/CriticMarkup-toolkit
WANTS_CM='n'
if [ -d "$DOTFILE_DIRECTORY/CriticMarkup-toolkit" ]
then
  WANTS_CM='y'
else
  echo "If you're a MultiMarkdown user, we'll install the CriticMarkup-toolkit."
  read -r -p "ARE you a MultiMarkdown user? [y/N] " response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    WANTS_CM='y'
  fi
fi

if [ "$WANTS_CM" = 'y' ]
then
  CRIT_DIR="$DOTFILE_DIRECTORY/CriticMarkup-toolkit"
  if [ -d "$CRIT_DIR" ]; then
    echo "Updating CriticMarkup-toolkit"
    cd $CRIT_DIR && git pull
  else
    # Cloning to $CRIT_DIR
    echo "=> Cloning CriticMarkup-toolkit into $CRIT_DIR"
    git clone https://github.com/CriticMarkup/CriticMarkup-toolkit.git $CRIT_DIR
  fi
  cd $DOTFILE_DIRECTORY
  if [ -d "$CRIT_DIR" ]
  then
    echo "Symlinking CriticMarkup-toolkit in $SCRIPT_DIRECTORY"
    link_if_necessary "$CRIT_DIR/Marked Processor" "$SCRIPT_DIRECTORY" "critic.py" "marked_processor_critic.py"
  else
    echo "Can't directory $CRIT_DIR for symlinks to the CriticMarkup-toolkit scripts."
  fi
fi
