#!/usr/bin/env bash

running=$(eww get timer_running)
eww update switch='false'
if [[ $running == 'true' ]];then
eww update switch='true'
cancel=$(eww get clock_timer_cancel)
if [[ $cancel == 'true' ]];then
  eww update timer_running='false' &
  eww update clock_timer_cancel='false' &
  echo 'should kill timer'
  pkill timer &
  echo 0 > /tmp/clock_timer
  exit
else
  echo 'Timer already running'
fi
return
fi
tick=$(cat /tmp/clock_timer)
./scripts/timer eww $tick start &
