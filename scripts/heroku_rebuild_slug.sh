#!/bin/bash

# Force a Heroku slug recompilation.
# CDs into the specified directory, then
# 1. Pulls it,
# 2. Creates an empty commit,
# 3. Pushes that commit to origin, then 
# 4. Pushes it to Heroku, forcing a slug recompilation.

if [ $# -gt 0 ]; then
    cd $1
    git pull
    git commit --allow-empty -m "Empty commit for Heroku slug recompilation"
    git push origin
    git push heroku
else
    echo "Error: location of repo to push is required as sole argument."
    exit 1
fi