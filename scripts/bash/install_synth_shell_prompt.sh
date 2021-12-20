#!/bin/bash
HOME_DIR=$1
BASH_CONFIG_DIR=$2

pushd "$(dirname "$0")"
DEPENDENCIES_DIR="../../dependencies"
SYNTH_SHELL_SOURCE_DIR="$DEPENDENCIES_DIR/synth-shell-prompt"
SYNTH_SHELL_OUTPUT_SCRIPT="$HOME_DIR/.bash/synth-shell/synth-shell-prompt.sh"
SYNTH_SHELL_CONFIG_DIR="$BASH_CONFIG_DIR/synth-shell"

if [ ! -d "$SYNTH_SHELL_SOURCE_DIR" ]; then
  git clone \
    -b custom-install \
    --recursive \
    https://github.com/jbernie2/synth-shell-prompt \
    $SYNTH_SHELL_SOURCE_DIR
fi

pushd "../../dependencies/synth-shell-prompt"
source ./setup.sh \
  $SYNTH_SHELL_OUTPUT_SCRIPT \
  $SYNTH_SHELL_CONFIG_DIR \
  n

popd
cp -f \
  "../../configs/synth-shell/synth-shell-prompt.sh" \
  $BASH_CONFIG_DIR
