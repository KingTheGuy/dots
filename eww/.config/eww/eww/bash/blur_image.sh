#!/usr/bin/env bash

IMAGE=""

while true ;do
  NEW_IMAGE=$(playerctl metadata mpris:artUrl)
  # NEW_IMAGE=$(eww get now_playing_image)
  if [[ $IMAGE != $NEW_IMAGE ]];then
    eww update load_player_background=false
    echo "player background updated"
    IMAGE=$NEW_IMAGE
    # ffmpeg -y -i $IMAGE -vf "gblur=sigma=8:steps=2" bash/blur_image_name.jpeg
    # ffmpeg -y -i $IMAGE -vf "gblur=sigma=8:steps=2" bash/blur_image_name.jpeg 2> /dev/null
    ffmpeg -y -i $IMAGE -vf "gblur=sigma=12:steps=2" bash/blur_image_name.jpeg 2> /dev/null

    # convert $IMAGE -filter Gaussian -blur 0x8 bash/blur_image_name.jpeg
    eww update player_blured_image='bash/blur_image_name.jpeg'
    eww update load_player_background=true

    # last_image=$(eww get now_playing_image)
    last_image=$NEW_IMAGE
    eww update last_image=$last_image
  fi
  # eww update reload_style='opacity:0;'
  # echo $IMAGE

  sleep 1
done
