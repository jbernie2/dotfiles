#!/bin/bash
cd "$(dirname "$0")"
install_dir=$1
cp -f ../../configs/vim/.vimrc $install_dir
