#!/bin/bash

volume_level () {
  cmd=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d "." -f 2)
  volume=$cmd
  if [[ $cmd == "1.0" ]]; then
    volume="100"
  fi

  echo the volume: $volume
  dunstify -r 12 -t 800 "Volume: " -h int:value:$volume
}

volume_level
