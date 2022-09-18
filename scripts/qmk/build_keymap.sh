#!/bin/bash

keyboard_dir=$1
keyboard_name=$2
github_username=$3

build_layout() {
  qmk_home=$1
  keyboard_dir=$2
  keyboard_name=$3
  github_username=$4

  echo "building layout for $keyboard_name..."

  source_dir="$keyboard_dir/$keyboard_name/src"
  dest_dir="$qmk_home/keyboards/$keyboard_name/keymaps/$github_username"

  mkdir -p $dest_dir

  cp $source_dir $dest_dir
  qmk compile -kb $keyboard_name -km $github_username

  hex_source="$qmk_home/${keyboard_name}_${github_username}.hex"
  hex_dest="$keyboard_dir/$keyboard_name/bin"
  echo "moving compiled keymap to $hex_dest"

  mkdir -p $hex_dest
  cp $hex_source $hex_dest
}

if [ -z $(which qmk) ];
then 
  echo "Error: QMK not installed 
    QMK required to build layout.
    See https://docs.qmk.fm/ for installation instructions"; 
else 
  qmk_home=$(qmk env | grep QMK_HOME | sed 's/\(QMK_HOME=\)//g;s/\"//g')
  build_layout $qmk_home $keyboard_dir $keyboard_name $github_username
fi

