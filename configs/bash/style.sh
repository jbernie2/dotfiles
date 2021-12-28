# change prompt appearance
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}
export PS1="\$(parse_git_branch) 𝄢 "
export PS2='> '

# for information on this cryptic string see:
# https://www.cyberciti.biz/faq/apple-mac-osx-terminal-color-ls-output-option/
export LSCOLORS=gxfxcxdxbxegedabagacad
