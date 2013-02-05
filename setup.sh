#!/bin/bash

# Find the location of the script.
DOTFILE_DIRECTORY=`pwd`

echo "Creating symbolic links in home directory..."

ln -is "$DOTFILE_DIRECTORY/.alias" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.bash_profile" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.bashrc" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.gitconfig" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.gitignore" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.inputrc" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.railsrc" "$HOME"
ln -is "$DOTFILE_DIRECTORY/.gemrc" "$HOME"

echo "...symbolic links created."

echo "Running .osx preferences script..."
chmod 777 ./.osx
./.osx
