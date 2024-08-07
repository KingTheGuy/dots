#!/usr/bin/env bash


if [[ $1 == "nightlight" ]]
then
  # pactl set-sink-mute @DEFAULT_SINK@ toggle
  echo hi
  else
    if [[ $1 == "up" ]]
    then
      light -A 0.3%
    elif [[ $1 == "down" ]]
    then
      light -U 0.3%
    fi
fi


level="$(light -G)"
# notify-send -t 500 "$level"
/home/boots/STUFF/eww/target/release/eww update light_level="$level"
# /home/boots/STUFF/eww/target/release/eww update light_level=$(($light * 100))

