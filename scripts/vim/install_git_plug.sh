#!/bin/bash

install_dir=$1
git_plug_dir="$install_dir/.vim/autoload/plug.vim"
if [ ! -d $git_plug_dir ]; then
  curl -fLo $install_dir/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
