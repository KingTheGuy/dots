#!/usr/bin/env bash

pane_right=$(tmux display-message -p '#{pane_right}')

window_width=$(tmux display-message -p '#{window_width}')
window_width=$((window_width - 1))

# tmux display-message "$window_width"
if [ "$pane_right" -eq "$window_width" ]; then
    tmux select-window -n
else
    tmux select-pane -R
fi
