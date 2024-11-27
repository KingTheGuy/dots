#!/bin/bash
# if [[ $1 == "get_mute" ]];then
# else
# fi
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
if [[ $muted == *"[MUTED]"* ]];then
  eww update mute_audio=true
  # notify-send muted
else
  eww update mute_audio=false
  # notify-send unmuted
fi
