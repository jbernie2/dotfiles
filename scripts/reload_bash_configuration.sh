#!/bin/bash

case "$-" in
 *i*)
    # This shell is interactive
    $FILE = ~/.bash_profile
    if test -f "$FILE"; then
      source $FILE
    fi
    ;;
 *)
    # This shell is not interactive
    $FILE = ~/.bashrc
    if test -f "$FILE"; then
      source $FILE
    fi
    ;;
esac
