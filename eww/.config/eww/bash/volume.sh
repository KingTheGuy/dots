#!/bin/env bash

if [[ $1 == "up" ]]; then
	eww update pro=$(($(eww get pro) + $2))
else
	eww update pro=$(($(eww get pro) - $2))
fi

/home/olrak/.config/eww/bash/update_volume.sh
