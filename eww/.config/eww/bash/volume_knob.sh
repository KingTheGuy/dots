#!/bin/bash

if [[ "$2" == "popup" ]]; then
	exec ~/.config/eww/bash/delay.sh "reveal_knob" &
fi

limit="-l 1.4"

volume=$(tail /tmp/eww_volume -n1)
if [[ "$1" == "up" ]]; then
	# wpctl set-volume $limit @DEFAULT_AUDIO_SINK@ 3%+
	volume=$(($volume + 0.1))
elif [[ "$1" == "down" ]]; then
	# wpctl set-volume $limit @DEFAULT_AUDIO_SINK@ 3%-
	volume=$(($volume - 0.1))
elif [[ "$1" == "mute" ]]; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	eww poll volume_muted
fi

# eww poll volume
# volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f2)
echo $volume
echo $volume >> /tmp/eww_volume
