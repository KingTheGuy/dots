#!/usr/bin/env bash

WP=$(wpctl status -nk)

IS_AUDIO="false"
IS_SINK="false"

for str in ${WP[@]};do
  if [[ $str == *"Audio"* ]];then
    IS_AUDIO="true"
    # echo "is audio"
  fi
  if [[ $IS_AUDIO == "true" ]]; then
    if [[ $str == *"Sinks"* ]];then
      IS_SINK="true"
    fi
  fi
  if [[ $IS_SINK == "true" ]];then
    echo this $str
  fi
done
# echo $($WP | cut -)
