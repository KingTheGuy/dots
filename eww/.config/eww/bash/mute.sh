#!/bin/env bash

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
icon=$1
if [[ $muted == *"MUTED"* ]]; then
  icon=$2
else
  icon=$1
fi

eww update temp_icon_volume=$icon
