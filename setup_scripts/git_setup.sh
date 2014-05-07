#!/bin/bash

# Set up git configuration

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Symlinking git hook directory to ~/.git_hook_symlink_installer"
link_if_necessary "$DOTFILE_DIRECTORY" "$HOME" ".git_hook_symlink_installer"

# If writing to init.templatedir would overwrite an existing value,
# cache the old value away.
gitconfig_init_templatedir=`git config --global --get init.templatedir`
gitconfig_init_templatedirOLD=`git config --global --get init.templatedirOLD`
if [[ ("${#gitconfig_init_templatedir}" > 0) && ("${#gitconfig_init_templatedirOLD}" == 0) ]]; then
  echo "Copying old value of git variable init.templatedir to init.templatedirOLD."
  git config --global init.templatedirOLD "$gitconfig_init_templatedir"
fi
# OK, now, write (or overwrite) init.templatedir value.
git config --global init.templatedir '~/.git_hook_symlink_installer'

gitconfig_include_path=`git config --global --get-all include.path`
if [[ ! $gitconfig_include_path == *~/.gitconfig_shared* ]] ; then
  echo "Including ~/.gitconfig_shared in ~/.gitconfig"
  git config --global --add include.path "~/.gitconfig_shared"
fi
