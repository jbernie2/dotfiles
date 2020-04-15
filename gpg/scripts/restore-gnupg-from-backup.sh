#!/bin/sh

set -eu

gnupg=$HOME/.gnupg
latest_bkup=$(ls -dt ~/.gnupg.bak* | head -1)
tmpdir=$(mktemp -d)

echo "Backing up ~/.gnupg to $tmpdir"
mv $gnupg/*.conf $tmpdir

echo "Restoring latest backup"
cp -iR $latest_bkup/*.conf $gnupg
