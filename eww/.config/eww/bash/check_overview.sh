#!/bin/env bash

overview=$(niri msg overview-state)

if [[ $overview == *"closed"* ]]; then
  eww update backdrop_visible=true
else
  eww update backdrop_visible=false
fi

niri msg action toggle-overview
# notify-send "$(eww get backdrop_visible)"
