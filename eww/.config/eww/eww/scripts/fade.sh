#!/usr/bin/env bash
eww="eww"
# $eww update toggle_date_time='true'
if [[ $1 == "true" ]];then
    $eww update reveal_var='false'
    sleep 0.15
    $eww update toggle_date_time='false'
    $eww update reveal_var='true'
else
    # echo "this is running"
    $eww update reveal_var='false'
    sleep 0.4
    $eww update toggle_date_time='true'
    $eww update reveal_var='true'
fi
