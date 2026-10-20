#!/usr/bin/env bash
# Zoom several panes at once.
#   multizoom.sh mark <L|D|U|R> [pane]  mark the pane, move in that direction, mark that one too
#   multizoom.sh toggle [pane]          hide every unmarked pane in the pane's window, or bring
#                                       them back if they are already hidden
#   multizoom.sh clear [pane]           forget the marks in the pane's window
# Hidden panes are moved to a window named "zstash"; the original layout is saved and restored.
# The pane defaults to $TMUX_PANE; key bindings pass #{pane_id} explicitly.
set -euo pipefail

cmd=${1:-}
case "$cmd" in
  mark) dir=${2:-}; pane=${3:-${TMUX_PANE:-}} ;;
  toggle|clear) pane=${2:-${TMUX_PANE:-}} ;;
  *) echo "usage: $0 mark <L|D|U|R> [pane] | toggle [pane] | clear [pane]" >&2; exit 2 ;;
esac
[ -n "$pane" ] || { echo "multizoom: no target pane" >&2; exit 2; }
win=$(tmux display -p -t "$pane" '#{window_id}')

clear_marks() {
  for p in $(tmux list-panes -t "$win" -F '#{pane_id}'); do
    tmux set -p -t "$p" -u @mz_sel 2>/dev/null || true
  done
}

case "$cmd" in
  mark)
    tmux set -p -t "$pane" @mz_sel 1
    tmux select-pane -t "$pane" "-$dir" 2>/dev/null || exit 0
    tmux set -p -t "$win" @mz_sel 1  # the window's new active pane
    ;;
  clear)
    clear_marks
    ;;
  toggle)
    stash=$(tmux show -wqv -t "$win" @mz_stash)
    if [ -n "$stash" ]; then
      layout=$(tmux show -wqv -t "$win" @mz_layout)
      order=$(tmux show -wqv -t "$win" @mz_order)
      for p in $(tmux list-panes -t "$stash" -F '#{pane_id}'); do
        tmux join-pane -d -s "$p" -t "$win"
      done
      # select-layout fills slots in pane order, so put the panes back in their original order
      i=1
      for want in $order; do
        have=$(tmux list-panes -t "$win" -F '#{pane_id}' | awk -v n="$i" 'NR == n')
        if [ -n "$have" ] && [ "$have" != "$want" ]; then
          tmux swap-pane -d -s "$have" -t "$want"
        fi
        i=$((i + 1))
      done
      tmux select-layout -t "$win" "$layout"
      tmux select-pane -t "$pane"
      tmux set -w -t "$win" -u @mz_stash
      tmux set -w -t "$win" -u @mz_layout
      tmux set -w -t "$win" -u @mz_order
      clear_marks
      exit 0
    fi
    marked=$(tmux list-panes -t "$win" -F '#{pane_id} #{@mz_sel}' | awk '$2 == 1 { print $1 }')
    if [ -z "$marked" ]; then
      tmux resize-pane -Z -t "$pane"  # nothing marked: plain zoom
      exit 0
    fi
    others=$(tmux list-panes -t "$win" -F '#{pane_id} #{@mz_sel}' | awk '$2 != 1 { print $1 }')
    [ -n "$others" ] || exit 0  # everything is marked: nothing to hide
    tmux set -w -t "$win" @mz_layout "$(tmux display -p -t "$win" '#{window_layout}')"
    tmux set -w -t "$win" @mz_order "$(tmux list-panes -t "$win" -F '#{pane_id}' | tr '\n' ' ')"
    stash=""
    for p in $others; do
      if [ -z "$stash" ]; then
        # -a -t: the stash window sits right after this one, in this session
        stash=$(tmux break-pane -d -a -s "$p" -t "$win" -n zstash -P -F '#{window_id}')
      else
        tmux join-pane -d -s "$p" -t "$stash"
      fi
    done
    tmux set -w -t "$win" @mz_stash "$stash"
    ;;
esac
