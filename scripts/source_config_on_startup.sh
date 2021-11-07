#!/bin/bash
bash_config_home=$1
set_bash_home_command="BASH_CONFIG_HOME=$bash_config_home"
source_command='source "$HOME/.bash/source.sh"'
bash_profile=~/.bash_profile

if grep -x "$set_bash_home_command" ~/.bash_profile
then
  : # no op
else
  echo $set_bash_home_command >> $bash_profile
fi

if grep -x "$source_command" ~/.bash_profile
then
  : # no op
else
  echo $source_command >> $bash_profile
fi

