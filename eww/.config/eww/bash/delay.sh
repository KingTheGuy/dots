#!/bin/bash

# Check for existing instances
INSTANCE_COUNT=$(pgrep -c -f "$0")

latest=$(pgrep -n -f "$0")
if [ "$INSTANCE_COUNT" -gt 1 ]; then
    # echo "More than one instance of $SCRIPT_NAME is running. Killing the previous instance..."
    # to_kill=$(pgrep -f "$0")
    # for item in $to_kill; do
    #   if [[ "$item" != "$latest" ]]; then
    #     notify-send "this is $latest & $item"
    #     kill -p item
    #   fi
    # done
    pkill -o -f "$0"
  else
    if [[ $1 == "reveal_knob" ]];then
  		eww open popup --arg override="(volume_knob :override true)"
    fi
    if [[ $1 == "reveal_player" ]];then
  		eww open popup --arg override="(audio_vis :height 20 :width 3 :size wave_form :vert true)"
    fi
  	# eww update reveal_knob="true"
  	# active_window=$(eww active-windows)
fi


if [[ $# -eq 0 ]];then
  exit
fi

# eww update $1="true"
# eww open popup ##this should maybe not be here

sleep 1

# eww update $1="false"
sleep 0.1
eww close popup ##this should maybe not be here

exit
