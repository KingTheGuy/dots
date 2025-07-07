#!/bin/bash

# CREATE tmp files
# wpctl get-volume @DEFAULT_AUDIO_SINK@ | split column " " | get column2 | to text
# eww update content=""
eww open --toggle launcher
$HOME/.config/eww/go/notes/main
# $HOME/.config/eww/bash/launcher.sh :h
$HOME/.config/eww/go/launcher/main :h
if [[ $(eww active-windows) == *"launcher:"* ]];then
  eww update show_content=true
else
  eww update show_content=false
fi
