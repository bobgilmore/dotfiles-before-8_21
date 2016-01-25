#!/bin/bash

unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
    case "$1" in
  *_EDITMSG|*MERGE_MSG|*_TAGMSG )
      "$HOME/bin/subl -w $1"
      ;;
  *.md )
      "$HOME/bin/mmdc $1"
      ;;
  *.txt )
      "$HOME/bin/mmdc $1"
      ;;
  * )
      #"$HOME/bin/subl -w $1"
      vim "$1";
      ;;
    esac
else
    vim "$1";
fi
