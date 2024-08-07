#!/usr/bin/env bash

# FIXME: math wrong between timer and formatter
input=$1

# tick=$(tail -n 1 /tmp/clock_timer)
# tick=$(cat /tmp/time_left)
tick=$input
tick=$(($tick * 60))
H=00
M=00
S=00
if [[ $tick -gt 3600 ]];then
	H=$(($tick / 3600))
	H=$(($H % 99))
fi
if [[ $tick -gt 60 ]]; then
	M=$(($tick / 60))
	M=$(($M % 60))
	if [[ $M == 0 ]]; then
		M=00
	fi
fi
if [[ $tick -gt 0 ]]; then
	S=$(($tick % 60))
	if [[ $S == 0 ]]; then
		S=00
	fi
fi
ticks="$H\n$M\n$S\n"
# echo $ticks >> /tmp/clock_timer
# echo $ticks > /tmp/time_left
# eww update clock_timer_display=$ticks
eww update clock_timer_left_display=$ticks
echo $ticks
