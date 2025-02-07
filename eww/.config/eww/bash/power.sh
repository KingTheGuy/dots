#!/usr/bin/env bash
if [[ "$1" == "power-off" ]];then
  eww open power_widget --arg msg="powering off"
  sleep 2
  loginctl poweroff
elif  [[ "$1" == "reboot" ]];then
  eww open power_widget --arg msg="rebooing"
  sleep 2
  loginctl reboot
fi

# notify-send bye
