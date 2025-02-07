#!/usr/bin/env bash

IN=$1
arrIN=(${IN//// })
device=${arrIN[${#arrIN[@]}-1]/eww_}
echo $device

SPACE=$2
# eww update $2="($device)"
# inn=$1
# removed=${inn/file://""}
# device=$(cat $removed)

# eww update $2="$device"
eww update $2="($device)"

# WIDGET=$1
# this=$(pwd)
# ok=${WIDGET/$this/"shit"}
# notify-send $ok

# huh="what is up"
# echo ${huh/is/"going"}
