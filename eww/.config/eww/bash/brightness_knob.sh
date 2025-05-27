#!/bin/bash

# if [[ "$2" == "keybind" ]]; then
# 	eww update reveal_knob="true"
# 	exec ~/.config/eww/bash/delay.sh "reveal_brightness_knob" &
# fi

if [[ "$1" == "up" ]]; then
	light -A 1%
elif [[ "$1" == "down" ]]; then
	light -U 1%
fi

# level="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f2)"
# eww update volume=$level
