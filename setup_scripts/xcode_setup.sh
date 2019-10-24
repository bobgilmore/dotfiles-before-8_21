#!/bin/bash

# Set up Xcode configuration

# Load env vars and functions
source "$(pwd)/setup_scripts/setup_utils.sh"

echo "Xcode..."

if [ ! -d "$XCODE_XCDEBUGGER" ]; then
  mkdir -p "$XCODE_XCDEBUGGER"
fi
echo "Symlinking bundles in $XCODE_XCDEBUGGER"
link_if_necessary "$DROPBOX_DIRECTORY/Library/Developer/Xcode/UserData/xcdebugger" "$XCODE_XCDEBUGGER" "Breakpoints_v2.xcbkptlist"

echo "... Xcode done"
