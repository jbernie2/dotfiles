#!/bin/bash
HOME_DIR=$1
BASH_CONFIG_DIR=$2

pushd "$(dirname "$0")"
DEPENDENCIES_DIR="../../dependencies"
SYNTH_SHELL_SOURCE_DIR="$DEPENDENCIES_DIR/synth-shell-greeter"
SYNTH_SHELL_OUTPUT_SCRIPT="$HOME_DIR/.bash/synth-shell/synth-shell-greeter.sh"
SYNTH_SHELL_CONFIG_DIR="$BASH_CONFIG_DIR/synth-shell"

if [ ! -d "$SYNTH_SHELL_SOURCE_DIR" ]; then
  git clone \
    -b osx \
    --recursive \
    https://github.com/jbernie2/synth-shell-greeter \
    $DEPENDENCIES_DIR/synth-shell-greeter
fi

pushd "../../dependencies/synth-shell-greeter"
source ./setup.sh \
  $SYNTH_SHELL_OUTPUT_SCRIPT \
  $SYNTH_SHELL_CONFIG_DIR

popd
cp -f \
  "../../configs/synth-shell/synth-shell-greeter.sh" \
  $BASH_CONFIG_DIR
