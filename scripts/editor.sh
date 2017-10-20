#!/bin/bash

echo $1
unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
    case "$1" in
  *_EDITMSG|*MERGE_MSG|*_TAGMSG|*git-rebase-todo )
      #"$HOME/bin/subl -w $1"
      #atom --wait "$1";
      "emacs $1"
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
