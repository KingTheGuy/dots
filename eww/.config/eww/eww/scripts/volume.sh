#!/usr/bin/env bash

function update() {
  /home/boots/STUFF/eww/target/release/eww update volume_level="$(pactl get-sink-volume @DEFAULT_SINK@ | tr -s ' ' | cut -d ' ' -f '5' | tr "%" " ")"
}

function isMute() {
  is_muted="$(pactl get-sink-mute @DEFAULT_SINK@ | tr -s ' ' | cut -d ' ' -f '2')"
  mute=""
  if [[ $is_muted == "yes" ]]
  then
    # mute="󰖁"
		mute=""
  else
    # mute="󰕾"
		mute=""
  fi
  /home/boots/STUFF/eww/target/release/eww update volume_icon="$mute"
}

if [[ $1 == "up" ]];then
  pactl set-sink-volume @DEFAULT_SINK@ +3%
fi

if [[ $1 == "down" ]];then
  pactl set-sink-volume @DEFAULT_SINK@ -3%
fi

if [[ $1 == "mute" ]];then
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  isMute
fi

if [[ $1 == "update" ]];then
  isMute
fi
update



