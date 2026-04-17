#!/bin/env bash

eww close bar
eww close bar

eww open bar
eww open backdrop

wallpaper=$(tail -n1 ~/.config/eww/.eww_wallpaper)

swaybg -m fill -i $wallpaper &
disown
