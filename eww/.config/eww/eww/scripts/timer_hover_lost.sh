#!/usr/bin/env bash

running=$1
cancel=$2
if [[ $running == 'true' ]];then
  eww update switch='true'
  echo 'Timer already running'
  if [[ $cancel == 'true' ]];then
    echo 'should kill timer'
    pkill timer &
    echo 0 >> /tmp/clock_timer
    eww update clock_timer_cancel='false' &
    eww update timer_running='false' &
    ./scripts/timer eww 0 cancel
    exit
  fi
  exit
fi
eww update switch='false'
echo "this should now be executing"
tick=$(tail -n 1 /tmp/clock_timer)
./scripts/timer eww "${tick}m" start &
