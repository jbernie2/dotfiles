#!/bin/bash
bash_config_home=$1
set_bash_home_command="export BASH_CONFIG_HOME=$bash_config_home"
source_command='source "$HOME/.bash/source.sh"'
add_functions_command='PATH=$BASH_CONFIG_HOME/functions:$PATH'
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

if grep -x "$add_functions_command" ~/.bash_profile
then
    : # no op
  else
      echo $add_functions_command >> $bash_profile
fi
