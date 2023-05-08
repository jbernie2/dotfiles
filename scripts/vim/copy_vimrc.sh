#!/bin/bash
cd "$(dirname "$0")"
install_dir=$1
cp -f ../../configs/vim/.vimrc $install_dir
cp -f ../../configs/vim/.vimiderc $install_dir
