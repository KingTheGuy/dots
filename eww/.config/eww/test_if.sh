#!/usr/bin/env bash
#
NEW_IMAGE=$(playerctl metadata mpris:artUrl)

echo $NEW_IMAGE

if [[ $NEW_IMAGE == *"file"* ]];then
  echo ok
fi

 # ok and then making this eww call is kinda slower

output=$(eww get all_players)

echo $output
