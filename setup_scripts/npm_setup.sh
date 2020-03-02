#!/bin/bash

# Set up npm packages

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "npm..."
if [ "$(uname)" = 'Darwin' ]; then
  npm install npm -g
  npm update -g
  npm install -g bower
  #npm install -g ember-cli
  #npm install -g phantomjs
  npm install -g six
  npm install six

  #npm install -g cordova
  #npm install -g ios-deploy
  #npm install -g ios-sim
fi
echo "...npm done."
