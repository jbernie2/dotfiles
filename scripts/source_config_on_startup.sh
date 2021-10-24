#!/bin/bash

source_command='source "$HOME/.bash/source.sh"'
bash_profile=~/.bash_profile

if grep -x source_command ~/.bashrc
then
  : # no op
else
  echo $source_command >> $bash_profile
fi
