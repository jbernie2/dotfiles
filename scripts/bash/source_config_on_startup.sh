#!/bin/bash
bash_config_home=$1
bash_profile=$2
set_bash_home_command="export BASH_CONFIG_HOME=$bash_config_home"
source_command='source "$HOME/.bash/source.sh"'

if grep -x "$set_bash_home_command" "$bash_profile"
then
  : # no op
else
  echo $set_bash_home_command >> $bash_profile
fi

if grep -x "$source_command" "$bash_profile"
then
  : # no op
else
  echo "fails here?"
  echo "$source_command"
  echo "$bash_profile"
  echo $source_command >> $bash_profile
fi

