#!/bin/bash

case "$-" in
 *i*)
    # This shell is interactive
    FILE="$HOME/.bash_profile"
    if test -f "$FILE"; then
      source $FILE
    fi
    ;;
 *)
    # This shell is not interactive
    FILE="$HOME/.bashrc"
    if test -f "$FILE"; then
      source $FILE
    fi
    ;;
esac
