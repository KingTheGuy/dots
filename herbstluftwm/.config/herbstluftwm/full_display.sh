#!/bin/bash
THERE="$(herbstclient list_monitors | grep 'full' || echo false)"
if [[ "$THERE" == "false" ]]; then
  # echo false
  # herbstclient chain "," add_monitor 2560x1080+0+0 9 full , move_index 8 , focus_monitor full
  # herbstclient attr monitors.focus.index > /tmp/last_tag
  # herbstclient attr tags.focus.index > /tmp/last_tag
  herbstclient attr monitors.focus.name > /tmp/last_name
  herbstclient chain "," add_monitor 2560x1080+0+0 9 full , use_index 8 , focus_monitor full
else
  # echo true
  # herbstclient chain "," move_index 4 , focus_monitor bottom , remove_monitor full
  # last_tag=$(cat /tmp/last_tag)
  last_name=$(cat /tmp/last_name)
  if [ -z "$last_name" ]; then
    last_name=0
  fi
  # echo $last_tag
  echo $last_name
  herbstclient chain ","  use_index 8 , focus_monitor "$last_name" , remove_monitor full
fi   

## focus the last tag/workspace
## this will move the current workspace to monitor 8/9
# herbstclient use_index 8

## then we focus monitor "full"
#herbstclient focus_monitor full



##using a tmp file to read from
##get the windows to go back to the workspace there where at
# ID of window
# herbstclient attr clients.focus.winid
# workspace name
# herbstclient attr tags.focus.name
