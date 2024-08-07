#!/usr/bin/env bash

pane_left=$(tmux display-message -p '#{pane_left}')

# tmux display-message "$pane_left"
if [ "$pane_left" -eq 0 ]; then
    # tmux previous-window
    tmux select-window -l
else
    tmux select-pane -L
fi
exit
