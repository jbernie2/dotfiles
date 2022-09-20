#!/bin/bash

keyboard_dir=$1
keyboard_name=$2
github_username=$3
dry_run=$4

build_layout() {
  qmk_home=$1
  keyboard_dir=$2
  keyboard_name=$3
  github_username=$4
  dry_run=$5

  source_dir="$keyboard_dir/$keyboard_name/src"
  dest_dir="$qmk_home/keyboards/$keyboard_name/keymaps/$github_username"

  mkdir -p $dest_dir

  cp $source_dir $dest_dir

  if [ $dry_run == "false" ]; then
    echo "building and flashing layout for $keyboard_name..."
    qmk flash -kb $keyboard_name -km $github_username
  else
    echo "building layout for $keyboard_name..."
    qmk compile -kb $keyboard_name -km $github_username
  fi
}

if [ -z $(which qmk) ];
then 
  echo "Error: QMK not installed 
    QMK required to build layout.
    See https://docs.qmk.fm/ for installation instructions"; 
else 
  qmk_home=$(qmk env | grep QMK_HOME | sed 's/\(QMK_HOME=\)//g;s/\"//g')
  build_layout \
     $qmk_home \
     $keyboard_dir \
     $keyboard_name \
     $github_username \
     $dry_run
fi

