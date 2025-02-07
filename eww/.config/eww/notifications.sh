#!/usr/bin/env bash

noti=$(dunstctl history)

output=$(echo $noti | jq '.[] | message')
echo $output

# listen for notifications
# dbus-monitor destination=org.freedesktop.Notifications
