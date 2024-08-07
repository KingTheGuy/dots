#!/usr/bin/env bash

function running () {
  this=$(eww get timer_running 2> /dev/null)
  echo $this
}

bool="$(running)"
if [[ $bool == "false" ]];then
  echo yes
fi
