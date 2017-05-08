#!/bin/bash

install_dir=$HOME

mkdir $install_dir/
mkdir $install_dir/.bash
cp -vR .bash/ $install_dir/.bash
cp -v .bash_profile $install_dir
cp -v .tmux.conf $install_dir
