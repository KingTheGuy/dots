#!/bin/bash
#update vars

while true;do
  volume=$(tail -n1 /tmp/eww_volume)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume
  # echo $volume
  sleep 0.2
done
