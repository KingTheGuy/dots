#!/usr/bin/env bash

# gets workspaces and their info
# dkcmd status type=ws num=1
spaces=$(dkcmd status type=ws num=1 | cut -d ':' -f '2')
icons=["󱂈","󱂉","󱂊","󱂋","󱂌","󱂍","󱂎","󱂏","󱂐"]

current=0
work_space=""
while [[ $current -lt 10 ]]
do
  current=$(($current + 1))
  spaces=$(dkcmd status type=ws num=1 | cut -d ':' -f "$current")
  if [[ $spaces == *"i"* ]]
  then
    work_space="$work_space _"
  elif [[ $spaces == *"a"* ]]
  then
    work_space="$work_space -"
  else
    work_space="$work_space /"

  fi
done
echo $work_space
