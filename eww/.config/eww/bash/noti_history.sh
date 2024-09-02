#!/usr/bin/env bash
num=""
# noti=$(dunstctl history | jq -c "[. | {name:.data.[].[$num].appname.data, msg:.data.[].[$num].message.data, time:.data.[].[$num].timestamp.data}]")
# what=".data.[].[]"
# noti=$(dunstctl history | jq -c "[. | {name:$what.appname.data, msg:$what.message.data, timestamp:$what.timestamp.data, id:$what.id.data}]")
what=".data.[].[]"
# noti=$(dunstctl history | jq -c "[.data.[].[] | {name:.appname.data, msg:.message.data, timestamp:.timestamp.data, id:.id.data}]")
noti=$(dunstctl history | jq -c "[.data.[].[] | {name:.summary.data,app:.appname.data, msg:.body.data, timestamp:.timestamp.data, id:.id.data}]")
# while true ;do
# for i in $noti;
# do
# 	echo $i
# done
eww update to_read="$noti"
# echo $noti
	# sleep 1
# done
# jq $noti

# listen for notifications
# dbus-monitor destination=org.freedesktop.Notifications
