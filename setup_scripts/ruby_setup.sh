#!/bin/bash

# Set up Ruby and related tools

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Configuring bundle..."
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))
