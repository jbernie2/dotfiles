if command -v tmux &> /dev/null && \
  [ "$TERM_PROGRAM" = "iTerm.app" ] && \
  [ -n "$PS1" ] && \
  [[ ! "$TERM" =~ screen ]] && \
  [[ ! "$TERM" =~ tmux ]] && \
  [ -z "$TMUX" ]; then
  exec tmux
fi
