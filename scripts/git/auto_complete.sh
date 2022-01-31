#!/bin/bash
config_dir=$1
git_completion_dest="$config_dir/git-completion.bash"

if [ ! -f $git_completion_dest ]
then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $git_completion_dest
fi
