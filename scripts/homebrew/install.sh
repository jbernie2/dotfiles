#!/bin/bash
if hash brew 2>/dev/null; then
  : # no op
else
  /bin/bash -c \
    "$(curl -fsSL \
        https://raw.githubusercontent.com/Homebrew/install/master/install.sh \
      )"
fi
