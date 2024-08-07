#!/usr/bin/env bash
# light -G
# light -A 10
# echo "changed to:"
light -G

# exit

# backlight_cmd="/sys/class/backlight/intel_backlight"

# current=$(cat "$backlight_cmd/actual_brightness")

amount=$2

# echo $current
# exit
if [[ $1 == "+" ]]
then
  # amount=$(($current + $amount))
  # echo $amount
  # $(echo $amount > "$backlight_cmd/brightness")
  light -A $amount

elif [[ $1 == "-" ]]
then
  # amount=$(($current - $amount))
  # $("$backlight_cmd/brightness")
  # echo $amount
  light -U $amount

fi

# echo $amount
