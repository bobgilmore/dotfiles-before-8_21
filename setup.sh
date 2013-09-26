#!/bin/bash

# Find the location of the script.
DOTFILE_DIRECTORY=`pwd`
BIN_DIRECTORY="$HOME/bin"
SCRIPT_DIRECTORY="$HOME/scripts"
OLD_DROPBOX_DIRECTORY="$HOME/Dropbox"
DROPBOX_DIRECTORY="$HOME/Dropbox/dotfile_symlinks"
LIB_SUBLIME="Library/Application Support/Sublime Text 2"
HOME_VIM="$HOME/.vim"

create_link_if_necessary() {
  local sourcefile="$3"
  local sourcedir="$1"
  local targetdir="$2"
  if [ -z "$4" ]
  then
    local targetfile="$3"
  else
    local targetfile="$4"
  fi

  if !([ -e "$targetdir/$targetfile" ] && [[ $(readlink "$targetdir/$targetfile") = "$sourcedir/$sourcefile" ]])
  then
    ln -is "$sourcedir/$sourcefile" "$targetdir/$targetfile"
  fi
}

echo "Symlinking dotfiles in ~"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".alias"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".bash_profile"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".bashrc"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".bash.colors"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".gitconfig"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".gitignore"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".inputrc"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".railsrc"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".gemrc"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".vimrc"
create_link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".alias"

echo "Symlinking local helper apps in ~/bin"
mkdir -p "$BIN_DIRECTORY"
if [ -f "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ]
then
  create_link_if_necessary "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin" "$BIN_DIRECTORY" "subl"
else
echo "Can't find /Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl for symlink."
fi

echo "Symlinking helper scripts in ~/scripts"
mkdir -p "$SCRIPT_DIRECTORY"
create_link_if_necessary "$DOTFILE_DIRECTORY/scripts" "$SCRIPT_DIRECTORY" "editor.sh"

# Deal with constantly-changing files (that shouldn't be checked in) stored on Dropbox
# Start by detecting old setups and warning appropriately.
if [ -d "$OLD_DROPBOX_DIRECTORY/$LIB_SUBLIME/Installed Packages" ]; then
  if [ -d "$DROPBOX_DIRECTORY/$LIB_SUBLIME/Installed Packages" ]; then
    echo "WARNING: Redundant directory structures in Dropbox."
    echo -e "Remove\n$OLD_DROPBOX_DIRECTORY/$LIB_SUBLIME \nin favor of \n$DROPBOX_DIRECTORY/$LIB_SUBLIME\nand run setup.sh again."
  else
    echo "ERROR: Old directory structure in Dropbox."
    echo -e "Move\n$OLD_DROPBOX_DIRECTORY/$LIB_SUBLIME \nto \n$DROPBOX_DIRECTORY/$LIB_SUBLIME\nand run setup.sh again."
  fi
fi
if [ -d "$DROPBOX_DIRECTORY/$LIB_SUBLIME/Installed Packages" ]
then
  echo "Symlinking Sublime Text 2 in ~/Library/Application Support/"
  create_link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME" "$HOME/$LIB_SUBLIME" "Installed Packages"
  create_link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME" "$HOME/$LIB_SUBLIME" "Packages"
  create_link_if_necessary "$DROPBOX_DIRECTORY/$LIB_SUBLIME" "$HOME/$LIB_SUBLIME" "Pristine Packages"
else
  echo "Can't find $DROPBOX_DIRECTORY/Library/Application Support/Sublime Text 2/Installed Packages/ for symlinks."
fi

if [ -d "$OLD_DROPBOX_DIRECTORY/$HOME_VIM" ]; then
  if [ -d "$DROPBOX_DIRECTORY/$HOME_VIM"]; then
    echo "WARNING: Redundant directory structures in Dropbox."
    echo -e "Remove \n$OLD_DROPBOX_DIRECTORY/$HOME_VIM \nin favor of \n$DROPBOX_DIRECTORY/$HOME_VIM\nand run setup.sh again."
  else
    echo "ERROR: Old directory structure in Dropbox."
    echo -e "Move \n$OLD_DROPBOX_DIRECTORY/$HOME_VIM \nto \n$DROPBOX_DIRECTORY/$HOME_VIM\nand run setup.sh again."
  fi
fi

# Install Vim addons...
# From https://github.com/tpope/vim-pathogen
echo -e "Installing Vim pathogen into $HOME_VIM/autoload"
mkdir -p $HOME_VIM/autoload
curl -Sso $HOME_VIM/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo "Symlinking Vim bundles in $HOME_VIM/bundle"
create_link_if_necessary "$DROPBOX_DIRECTORY/vim" "$HOME_VIM" "bundle"
# Done with Vim

if [ -d "$DROPBOX_DIRECTORY" ]; then
echo "This directory exists for use by https://github.com/bobgilmore/dotfiles

It contains directories and files that apps (such as Sublime Text and Vim)
constantly modify, and which therefore aren't really suited for
checking in to git.

This README.md was created by the github project's setup.sh script for
informational purposes.

See the github repo for more information.

20 September 2013, Bob Gilmore
" > "$DROPBOX_DIRECTORY/README.md"
fi
#Finished with Dropbox files.

# Perform operations that only make sense on a Mac...
if [ $(uname) = 'Darwin' ]
then
  
  # Install Brett Terpstra's na script - https://github.com/ttscoff/na
  if [ -d "/Applications/TaskPaper.app" ]
  then
    NA_DIR="$DOTFILE_DIRECTORY/na"
    echo "Handling Brett Terpstra's NA script for TaskPaper"
    if [ -d "$NA_DIR" ]; then
      cd $NA_DIR && git pull
    else
      # Cloning to $NA_DIR
      echo "=> Cloning NA repo into $NA_DIR"
      git clone https://github.com/ttscoff/na.git $NA_DIR
    fi
    cd $DOTFILE_DIRECTORY
    if [ -d "$NA_DIR" ]
    then
      echo "Symlinking NA in $SCRIPT_DIRECTORY"
      create_link_if_necessary "$NA_DIR" "$SCRIPT_DIRECTORY" "na.sh"
    else
      echo "Can't find directory $NA_DIR for symlink to the NA script."
    fi
  else
    echo "Skipping Brett Terpstra's NA project since TaskPaper not installed."
  fi


  # Install the CriticMarkup-toolkit.  See http://brettterpstra.com/2013/05/18/criticmarkup-in-marked-1-dot-4/ and https://github.com/CriticMarkup/CriticMarkup-toolkit
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
      create_link_if_necessary "$CRIT_DIR/Marked Processor" "$SCRIPT_DIRECTORY" "critic.py" "marked_processor_critic.py"
    else
      echo "Can't directory $CRIT_DIR for symlinks to the CriticMarkup-toolkit scripts."
    fi
  fi
  
  echo "Running .osx preferences script"
  chmod 777 ./.osx
  ./.osx
fi
