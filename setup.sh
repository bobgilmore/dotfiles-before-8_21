#!/bin/bash

# Find the location of the script.
DOTFILE_DIRECTORY=`pwd`
BIN_DIRECTORY="$HOME/bin"
SCRIPT_DIRECTORY="$HOME/scripts"

echo "Creating symbolic links for dotfiles in home directory..."

ln -is "$DOTFILE_DIRECTORY/.alias" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.bash_profile" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.bashrc" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.bash.colors" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.gitconfig" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.gitignore" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.inputrc" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.railsrc" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.gemrc" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.vimrc" "$HOME"

echo "Creating symbolic links for helper apps in ~/bin..."
mkdir -p "$BIN_DIRECTORY"
if [ -f "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ]
then
ln -is "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" "$BIN_DIRECTORY/subl"
else
echo "Could not find file /Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl in order to make a symbolic link to it."
fi

echo "Creating symbolic links for helper scripts in ~/scripts..."
mkdir -p "$SCRIPT_DIRECTORY"
ln -is "$DOTFILE_DIRECTORY/scripts/editor.sh" "$SCRIPT_DIRECTORY"

echo "Creating symbolic links from Sublime Text 2 Packages in Dropbox to ~/Library/Application Support/..."
if [ -d "$HOME/Dropbox/Library/Application Support/Sublime Text 2/Installed Packages" ]
then
ln -is "$HOME/Dropbox/Library/Application Support/Sublime Text 2/Installed Packages" "$HOME/Library/Application Support/Sublime Text 2"
else
echo "Could not find directory ~/Dropbox/Library/Application Support/Sublime Text 2/Installed Packages in order to make a symbolic link to it."
fi

if [ -d "$HOME/Dropbox/Library/Application Support/Sublime Text 2/Packages" ]
then
ln -is "$HOME/Dropbox/Library/Application Support/Sublime Text 2/Packages" "$HOME/Library/Application Support/Sublime Text 2"
else
echo "Could not find directory ~/Dropbox/Library/Application Support/Sublime Text 2/Packages in order to make a symbolic link to it."
fi

if [ -d "$HOME/Dropbox/Library/Application Support/Sublime Text 2/Pristine Packages" ]
then
ln -is "$HOME/Dropbox/Library/Application Support/Sublime Text 2/Pristine Packages" "$HOME/Library/Application Support/Sublime Text 2"
else
echo "Could not find directory ~/Dropbox/Library/Application Support/Sublime Text 2/Pristine Packages in order to make a symbolic link to it."
fi

echo "Creating symbolic links from ~/Dropbox/.vim to ~/.vim..."
if [ -d "$HOME/Dropbox/home/.vim" ]
then
ln -is "$HOME/Dropbox/home/.vim" "$HOME/.vim"
else
echo "Could not find directory ~/Dropbox/home/.vim in order to make a symbolic link to it."
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
      echo "=> NA is already installed in $NA_DIR, trying to update"
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
      ln -is "$NA_DIR/na.sh" "$SCRIPT_DIRECTORY/na.sh"
    else
      echo "Could not find directory $NA_DIR in order to make a symbolic link to the NA script."
    fi
  else
    echo "Skipping Brett Terpstra's na project since Hog Bay Software's TaskPaper is not installed."
  fi
  
  echo "Running .osx preferences script..."
  chmod 777 ./.osx
  ./.osx
fi
