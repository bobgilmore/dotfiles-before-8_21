#!/bin/bash

# Set up npm packages

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "npm..."
if [ $(uname) = 'Darwin' ]; then
  npm install npm -g
  npm update -g
  npm install -g bower
  npm install -g ember-cli
  npm install -g phantomjs
fi
echo "...npm done."
