#!/bin/bash

install_dir=$HOME

mkdir $install_dir/
mkdir $install_dir/.bash
cp -viR .bash/ $install_dir/.bash
cp -vi .bash_profile $install_dir
cp -vi .tmux.conf $install_dir
cp -vi .gitconfig $install_dir

# VIM CONFIG

#install vundle if not installed
vundle_script="${HOME}/.vim/bundle/Vundle.vim"
if [ ! -d $vundle_script ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

#copy over vimrc
cp -vi .vimrc $install_dir

#install vim plugins
vim +PluginInstall +qall
