
in_git_repo=$(
  git rev-parse --is-inside-work-tree 2>/dev/null ||
    echo "false"
)
if [ $in_git_repo = "true" ]; then
  # include paths from the repo's git ignore
  paths_to_ignore=$(git check-ignore *)
  ignore_file=$(mktemp)
  echo $paths_to_ignore > $ignore_file

  # pass file to ctags to ignore files specified by repo
  # in addition to files ignored by ctags config
  ctags --exclude=@$ignore_file -R

  rm $ignore_file
fi
