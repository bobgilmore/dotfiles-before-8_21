#!/bin/bash

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    case "$1" in
	*_EDITMSG|*MERGE_MSG|*_TAGMSG )
	    emacs "$1"
	    ;;
	*.md )
	    $HOME/bin/mmdc "$1"
	    ;;
	*.txt )
	    $HOME/bin/mmdc "$1"
	    ;;
	* )
	    $HOME/bin/subl -w "$1"
	    ;;
    esac
else
    emacs "$1";
fi
