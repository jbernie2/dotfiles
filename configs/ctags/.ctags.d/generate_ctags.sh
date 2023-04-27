
in_git_repo=$(
  git rev-parse --is-inside-work-tree 2>/dev/null ||
    echo "false"
)
if [ $in_git_repo = "true" ]; then
  ctags -R
fi
