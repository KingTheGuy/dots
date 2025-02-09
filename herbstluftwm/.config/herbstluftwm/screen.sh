#!/usr/bin/env bash

# sleep 5
# xrandr > output.txt
# sleep 2
# pkill herbstluftwm
# exit

# NOTE: i suck with bash scripts. im debating setting this script up with ZIG.

INTERNAL_DISPLAY="eDP-1-1"
EXTERNAL_DISPLAY="HDMI-1-1"

DISPLAYS=($(xrandr | grep connected | cut -d ' ' -f '1'))
# myarray=($DISPLAYS)
# echo "lets see: ${DISPLAYS[2]}"
EXTERNAL="$(xrandr | grep ${DISPLAYS[0]})"
split=(${EXTERNAL[0]})
# echo "is this split? ${split[1]}"
# echo $EXTERNAL
# echo $"${split[1]}"
exit

  echo yes
if [[ "${split[1]}" == "connected" ]]; then
  if [[ $1 == "game" ]];then
    xrandr --newmode "1712x720_60.00"   99.75  1712 1792 1968 2224  720 723 733 748 #-hsync +vsync
    xrandr --addmode $EXTERNAL_DISPLAY "1712x720_60.00"
    xrandr --output "$INTERNAL_DISPLAY" --off --output "$EXTERNAL_DISPLAY" --mode "1712x720_60.00" --auto --scale 1
    exit
  fi
  xrandr --output "$INTERNAL_DISPLAY" --off --output "$EXTERNAL_DISPLAY" --mode "2560x1080" --auto --scale 1
  ## ultrawide 720 3 sections
  # herbstclient set_monitors 1707x720+0+0
  # herbstclient add_monitor 1707x360+0+720 8 bottom
  # herbstclient add_monitor 853x1080+1707+0 7 right
  herbstclient set_monitors 853x1080+0+0
  herbstclient add_monitor 1707x720+853+0 2 right
  herbstclient add_monitor 1707x360+853+720 8 bottom

  # ## ultrawide 1080 3 sections
  # herbstclient set_monitors 1600x1080+0+0
  # # herbstclient add_monitor 1707x360+0+720 5 bottom
  # herbstclient add_monitor 960x1080+1600+0 4 right

  ## ultrawide 900 3 sections
  # herbstclient set_monitors 2128x900+0+0
  # herbstclient add_monitor 432x1080+2128+0 4 right
else
  # echo "LAPTOP"
  xrandr --output "$INTERNAL_DISPLAY" --mode "1600x900" --output "$EXTERNAL_DISPLAY" --off
  herbstclient detect_monitors
fi

# xrandr --newmode "2128x900_60.00"  157.75  2128 2248 2472 2816  900 903 913 934
# xrandr --addmode "$EXTERNAL_DISPLAY" "2128x900_60.00"
# xrandr --output "$INTERNAL_DISPLAY" --mode "1280x720" --output "$EXTERNAL_DISPLAY" --mode "2128x900_60.00+1280" --auto --scale 1
# herbstclient detect_monitors
# xrandr --output eDP1 --off --output HDMI1 --mode "2560x1080" --auto --scale 1
