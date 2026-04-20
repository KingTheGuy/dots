#!/bin/env bash

pkill swaybg

eww close bar
eww close backdrop

eww open bar
eww open backdrop

wallpaper=$(tail -n1 ~/.config/eww/.eww_wallpaper)

swaybg -m fill -i $wallpaper &
disown
