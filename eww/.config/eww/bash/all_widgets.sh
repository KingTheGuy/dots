#!/bin/bash
# NOTE: may be better to write this in go

# raw_items=$(ls $HOME/.config/eww/ | grep .yuck)
raw_items=$(cat $HOME/.config/eww/eww.yuck | grep defwidget)

echo $raw_items
