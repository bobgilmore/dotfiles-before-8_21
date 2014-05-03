#!/bin/bash

# Set up git configuration

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Symlinking and using git hooks in ~/.git_template_warning"
link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".git_template_warning"
git config --global init.templatedir '~/.git_template_warning'

gitconfig_include_path=`git config --global --get-all include.path`
if [[ ! $gitconfig_include_path == *~/.gitconfig_shared* ]] ; then
  echo "Including ~/.gitconfig_shared in ~/.gitconfig"
  git config --global --add include.path "~/.gitconfig_shared"
fi
