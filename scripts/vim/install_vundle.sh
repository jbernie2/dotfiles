#!/bin/bash

install_dir=$1
vundle_script="$install_dir/.vim/bundle/Vundle.vim"
if [ ! -d $vundle_script ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
