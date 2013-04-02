#!/bin/bash
 
case "$1" in
	*_EDITMSG|*MERGE_MSG|*_TAGMSG )
		/usr/local/bin/vim "$1"
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
