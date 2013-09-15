#!/bin/bash

# Find the location of the script.
DOTFILE_DIRECTORY=`pwd`
BIN_DIRECTORY="$HOME/bin"
SCRIPT_DIRECTORY="$HOME/scripts"

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

echo "Updating symbolic links for dotfiles in home directory..."
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

echo "Updating symbolic links for helper apps in ~/bin..."
mkdir -p "$BIN_DIRECTORY"
if [ -f "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ]
then
  create_link_if_necessary "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin" "$BIN_DIRECTORY" "subl"
else
echo "Could not find file /Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl in order to make a symbolic link to it."
fi

echo "Creating symbolic links for helper scripts in ~/scripts..."
mkdir -p "$SCRIPT_DIRECTORY"
create_link_if_necessary "$DOTFILE_DIRECTORY/scripts" "$SCRIPT_DIRECTORY" "editor.sh"

if [ -d "$HOME/Dropbox/Library/Application Support/Sublime Text 2/Installed Packages" ]
then
  echo "Creating symbolic links from Sublime Text 2 Packages in Dropbox to ~/Library/Application Support/..."
  create_link_if_necessary "$HOME/Dropbox/Library/Application Support/Sublime Text 2" "$HOME/Library/Application Support/Sublime Text 2" "Installed Packages"
  create_link_if_necessary "$HOME/Dropbox/Library/Application Support/Sublime Text 2" "$HOME/Library/Application Support/Sublime Text 2" "Packages"
  create_link_if_necessary "$HOME/Dropbox/Library/Application Support/Sublime Text 2" "$HOME/Library/Application Support/Sublime Text 2" "Pristine Packages"
else
  echo "Could not find ~/Dropbox/Library/Application Support/Sublime Text 2/Installed Packages/ in order to make symbolic links."
fi

echo "Creating symbolic links from ~/Dropbox/.vim to ~/.vim..."
if [ -d "$HOME/Dropbox/home/.vim" ]
then
  create_link_if_necessary "$HOME/Dropbox/home" "$HOME" ".vim"
else
echo "Could not find ~/Dropbox/home/.vim/ in order to make a symbolic link."
fi

echo "Symbolic links created."

# Perform operations that only make sense on a Mac...
if [ $(uname) = 'Darwin' ]
then
  
  # Install Brett Terpstra's na script - https://github.com/ttscoff/na
  if [ -d "/Applications/TaskPaper.app" ]
  then
    NA_DIR="$DOTFILE_DIRECTORY/na"

    if [ -d "$NA_DIR" ]; then
      echo "=> NA is already installed in $NA_DIR, updating..."
      echo -ne "\r=> "
      cd $NA_DIR && git pull
    else
      # Cloning to $NA_DIR
      git clone https://github.com/ttscoff/na.git $NA_DIR
    fi
    cd $DOTFILE_DIRECTORY
    if [ -d "$NA_DIR" ]
    then
      echo "Creating symbolic links for Brett Terpstra's NA in $SCRIPT_DIRECTORY..."
      create_link_if_necessary "$NA_DIR" "$SCRIPT_DIRECTORY" "na.sh"
    else
      echo "Could not find directory $NA_DIR in order to make a symbolic link to the NA script."
    fi
  else
    echo "Skipping Brett Terpstra's na project since Hog Bay Software's TaskPaper is not installed."
  fi


  # Install the CriticMarkup-toolkit.  See http://brettterpstra.com/2013/05/18/criticmarkup-in-marked-1-dot-4/ and https://github.com/CriticMarkup/CriticMarkup-toolkit
  echo "If you're a MultiMarkdown user, we'll install the CriticMarkup-toolkit."
  read -r -p "ARE you a MultiMarkdown user? [y/N] " response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    CRIT_DIR="$DOTFILE_DIRECTORY/CriticMarkup-toolkit"
    if [ -d "$CRIT_DIR" ]; then
      echo "=> CriticMarkup-toolkit is already installed in $CRIT_DIR, updating..."
      echo -ne "\r=> "
      cd $CRIT_DIR && git pull
    else
      # Cloning to $CRIT_DIR
      git clone https://github.com/CriticMarkup/CriticMarkup-toolkit.git $CRIT_DIR
    fi
    cd $DOTFILE_DIRECTORY
    if [ -d "$CRIT_DIR" ]
    then
      echo "Creating symbolic links for CriticMarkup-toolkit components in $SCRIPT_DIRECTORY..."
      create_link_if_necessary "$CRIT_DIR/Marked Processor" "$SCRIPT_DIRECTORY" "critic.py" "marked_processor_critic.py"
    else
      echo "Could not find directory $CRIT_DIR in order to make symbolic links to the CriticMarkup-toolkit scripts."
    fi
  fi
  
  echo "Running .osx preferences script..."
  chmod 777 ./.osx
  ./.osx
fi
