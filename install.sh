#!/bin/bash

install_dir=$HOME

mkdir $install_dir/
mkdir $install_dir/.bash
cp -viR .bash/ $install_dir/.bash
cp -vi .bash_profile $install_dir
cp -vi .tmux.conf $install_dir
