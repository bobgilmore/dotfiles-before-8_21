#!/bin/bash

# Set up npm packages

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "npm..."
if [ $(uname) = 'Darwin' ]; then
  npm install -g bower

fi
echo "...npm done."
