#!/bin/bash

simple_loop() {
  num=$((0 + $RANDOM % 3))
  echo $num
  eww update audio_vis_fade=$num
}
gen_n() {
  echo $(((2 + $RANDOM % 8) * 10))
  # echo 10
  # return 20
}
gen_waveform() {
  bar1=$(gen_n)
  bar2=$(gen_n)
  bar3=$(gen_n)
  bar4=$(gen_n)
  bar5=$(gen_n)
  bars="[$bar1,$bar2,$bar3,$bar4,$bar5]"
  echo $bars
  eww update wave_form=$bars
}

c_set=0
# sets=("[25,85,65,65,35]" ##
#       "[35,75,55,65,35]"
#       "[45,65,45,75,35]" ##
#       "[50,60,50,85,40]"
#       "[55,55,55,95,45]" ##
#       "[50,65,50,75,55]" 
#       "[45,75,45,65,65]" ##
#       "[50,65,55,60,55]" 
#       "[55,55,65,55,45]" ##
# )
sets=("[25,85,65]" ##
      "[35,75,55]"
      "[45,65,45]" ##
      "[50,60,50]"
      "[55,55,55]" ##
      "[50,65,50]" 
      "[45,75,45]" ##
      "[50,65,55]" 
      "[55,55,65]" ##
)



while true;do
  if [[ $(pgrep eww > /dev/null || echo "false") == "false" ]];then
    echo "killing script"
    pkill audio_vis.sh
  fi
  if [[ $(playerctl status) == "Playing" ]];then
    if [[ c_set -eq ${#sets[@]} ]];then
      c_set=0
    fi
    album_art=$(playerctl metadata | awk '/artUrl/ {print}' | sed -s 's/file:\/\///' | sed 's/.* //g')
    eww update wave_form=${sets[$c_set]}
    album_art_current=$(eww get album_art_current)
    # current_album_art=$(eww get album_art)

    # if [[ ]]
    ## BLUR IT ALL
    if [[ "$album_art_current" != "$album_art" ]];then
      # notify-send "update blur"
      eww update album_art="$album_art"
      eww update album_art_current="$album_art"
      # gblur=sigma=32
      ffmpeg -y -i $album_art -vf "gblur=sigma=8:steps=2" /tmp/eww_blur_image_name.jpeg
      eww update album_art_blurred="/tmp/eww_blur_image_name.jpeg"
    else
      eww update album_art="$album_art_current"
      eww update album_art_blurred="/tmp/eww_blur_image_name.jpeg"
    fi

    c_set=$((c_set + 1))
  else
    eww update wave_form="[20,20,20]"
    eww update album_art=""
    eww update album_art_blurred=""
  fi
  echo running
  # echo $(playerctl status)
  # echo working..
  # simple_loop
  # gen_waveform
  sleep 0.1
done
