#!/usr/bin/env bash
v=100
while [[ $v > 0 ]];do
  # echo hello
  v=$(($v - 1))
  echo $v
  if [[ $1 == "go" ]];then
    ./light $2
  else
    ./light_backup $2
  fi
  sleep 0.05
done
