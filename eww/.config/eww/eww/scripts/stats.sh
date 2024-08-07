#!/usr/bin/env bash
VALUE=$(eww get toggler)
# notify-send -t 1000 "$(date)" ## show time and date
if [[ $VALUE == "true" ]];then
  VALUE="false"
else
  VALUE="true"
fi
eww update toggler=$VALUE
# echo $VALUE
# notify-send -t 800 "$VALUE"
