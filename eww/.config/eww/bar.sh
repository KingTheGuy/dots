#!/bin/bash
#
pkill eww
eww open desktop
eww open bar

echo $(light -G) > /tmp/eww_brightness
echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f2) > /tmp/eww_volume

# notify-send $HOME
pkill audio_vis.sh
$HOME/.config/eww/bash/audio_vis.sh &
pkill update_vars.sh
$HOME/.config/eww/bash/update_vars.sh &
