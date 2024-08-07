#!/bin/bash

if [[ $1 == "up" ]]
  then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+
elif [[ $1 == "down" ]]
  then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-
else
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi

/home/boots/.config/eww/scripts/volume.sh


