#!/bin/bash

getWindow () {
    pid=$(herbstclient attr clients.focus.pgid)
    name=$(herbstclient attr clients.focus.instance)
}
getWindow
notify-send "Force killed $name"
pkill -ns $pid
# pkill -s $pid
