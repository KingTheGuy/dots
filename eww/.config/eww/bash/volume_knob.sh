#!/bin/bash

if [[ "$2" == "keybind" ]]; then
	exec ~/.config/eww/bash/delay.sh "reveal_knob" &
fi

if [[ "$1" == "up" ]]; then
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+
elif [[ "$1" == "down" ]]; then
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-
else
	# wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi

# level="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f2)"
# eww update volume=$level
