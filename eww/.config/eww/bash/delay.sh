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
		eww open popup --arg override="true"
  	# eww update reveal_knob="true"
  	# active_window=$(eww active-windows)
fi


if [[ $# -eq 0 ]];then
  exit
fi

# eww update $1="true"
# eww open popup ##this should maybe not be here

sleep 0.5

# eww update $1="false"
sleep 0.1
eww close popup ##this should maybe not be here

exit
