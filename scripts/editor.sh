#!/bin/bash

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    case "$1" in
	  *.md )
	    mmdc "$1"
	    ;;
	  * )
      vim "$1"
	    ;;
    esac
else
    vim "$1";
fi
