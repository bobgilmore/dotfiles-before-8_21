#!/bin/bash

# Set up shared git configuration

gitconfig_include_path=`git config --global --get-all include.path`
if [[ ! $gitconfig_include_path == *~/.gitconfig_shared* ]] ; then
  echo "Including ~/.gitconfig_shared in ~/.gitconfig"
  git config --global --add include.path "~/.gitconfig_shared"
fi
echo "...Git done."
