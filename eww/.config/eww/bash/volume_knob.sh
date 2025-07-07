#!/bin/bash

if [[ "$2" == "popup" ]]; then
	exec ~/.config/eww/bash/delay.sh "reveal_knob" &
fi

# limit="-l 1.2"
limit="-l 1.4"
# volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f2)
if [[ "$1" == "up" ]]; then
	wpctl set-volume $limit @DEFAULT_AUDIO_SINK@ 3%+
elif [[ "$1" == "down" ]]; then
	wpctl set-volume $limit @DEFAULT_AUDIO_SINK@ 3%-
elif [[ "$1" == "mute" ]]; then
	# wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	eww poll volume_muted
fi
# eww poll volume
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f2)
echo $volume >> /tmp/eww_volume
# level="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f2)"
# eww update volume=$level
