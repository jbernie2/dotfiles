#!/bin/bash
config_dir=$1

cd "$(dirname "$0")"
cp -fR ../../configs/bash/ $config_dir
