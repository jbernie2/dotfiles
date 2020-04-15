#!/bin/sh

set -eu

green='\033[0;32m'
yellow='\033[0;33m'
nocolor='\033[0m'

gnupg=$HOME/.gnupg
gnupg_bakup=$HOME/.gnupg.bak.$(date +%s)

backup_gpg_configuration_files()
{
  echo "${green}Backing up your .gnupg directory to $gnupg_bakup ${nocolor}"
  if [ ! -d "$gnupg_bakup" ]]
  then
    mkdir -p "$gnupg_bakup"
  fi

  if [ -e "$gnupg/gpg.conf" ]]
  then
    cp $gnupg/gpg.conf $gnupg_bakup 2> /dev/null
  fi

  if [ -e "$gnupg/gpg-agent.conf" ]]
  then
    cp $gnupg/gpg-agent.conf $gnupg_bakup 2> /dev/null
  fi

  if [ -e "$gnupg/dirmngr.conf" ]]
  then
    cp $gnupg/dirmngr.conf $gnupg_bakup 2> /dev/null
  fi

  if [ -e "$gnupg/scdaemon.conf" ]]
  then
    cp $gnupg/scdaemon.conf $gnupg_bakup 2> /dev/null
  fi

  if [ -d "$gnupg/trusted-certs" ]]
  then
    cp -R $gnupg/trusted-certs $gnupg_bakup 2> /dev/null
  fi
}

configure_gpg()
{
  echo "${green}Copying GPG configuration files... ${nocolor}"
  cp -i ./dotfiles/gnupg/gpg.conf $gnupg
  cp -i ./dotfiles/gnupg/dirmngr.conf $gnupg
  cp -i ./dotfiles/gnupg/scdaemon.conf $gnupg
  cp -iR ./dotfiles/gnupg/trusted-certs $gnupg

  if [ Linux = $(uname -s) ]
  then
    cp ./dotfiles/gnupg/gpg-agent.conf.linux $gnupg/gpg-agent.conf
  else
    cp ./dotfiles/gnupg/gpg-agent.conf.osx $gnupg/gpg-agent.conf
  fi
}

instruct_user_to_update_sh_conf()
{
  printf "${green}"
  printf "\n"
  printf "Done!\n"
  printf "Now, you'll want to ensure the following is part of your startup process.\n"
  printf "(.bashrc, .zshrc, etc)\n"
  printf "\n"

  printf "${yellow}"
  cat ./dotfiles/shellrc
  printf "\n"
  printf "${nocolor}"
}

# Create the ~/.gnupg directory in case it does not yet exist
mkdir -p $gnupg

if [ -d "$gnupg" ]]; then
  backup_gpg_configuration_files
fi

configure_gpg
instruct_user_to_update_sh_conf
