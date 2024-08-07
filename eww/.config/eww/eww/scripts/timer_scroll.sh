#!/usr/bin/env bash

# echo $1

# exit
interval=2
# running=$(eww get timer_running) # FIXME: do i need to be checking if its running on eaach scroll
if [[ $running == 'true' ]];then
    echo 'it is running..'
  if [[ $1 == 'up' ]];then
    eww update clock_timer_cancel='false'
  elif [[ $1 == 'down' ]];then
    eww update clock_timer_cancel='true'
    echo 0 > /tmp/clock_timer
    eww update timer_running='false'
    ./scripts/timer eww 0 cancel
  fi
  exit
fi
#tick=$(eww get clock_timer_left)
tick=$(cat /tmp/clock_timer)
if [[ $1 == 'up' ]];then
  echo $(($tick + $interval)) > /tmp/clock_timer
else
  if [[ $tick > 0 ]];then
    echo $(($tick - $interval)) > /tmp/clock_timer
    # ./scripts/timer eww $tick
  fi
fi
./scripts/tick_format.sh
