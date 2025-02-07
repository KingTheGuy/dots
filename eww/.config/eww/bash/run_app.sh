#!/usr/bin/env bash
# notify-send "this is running"
eww close launcher

# SELECTED=$(eww get apps | head -1) 
#
if [[ $1 != "" ]]; then
  SELECTED=$1
  else
  # SELECTED=$(eww get apps | head -1) 
  SELECTED=$(eww get apps | jq -r '.[0]')
fi
echo $SELECTED
# notify-send "$SELECTED"

# eww update gaps=' '
# go/launcher/main
exec nohup $SELECTED &
