#!/usr/bin/env bash

if [[ $1 == "true" ]];then
	/home/boots/STUFF/eww/target/release/eww update reveal_var='false'
	sleep 0.05
	/home/boots/STUFF/eww/target/release/eww update wait='true'
	sleep 0.05
	/home/boots/STUFF/eww/target/release/eww update view_date='true'
	sleep 2
fi
/home/boots/STUFF/eww/target/release/eww update view_date='false'
sleep 0.2
/home/boots/STUFF/eww/target/release/eww update wait='false'
/home/boots/STUFF/eww/target/release/eww update reveal_var='false'
sleep 0.05
/home/boots/STUFF/eww/target/release/eww update reveal_var='true'
