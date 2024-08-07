#!/bin/bash
# STATUS=$(herbstclient tag_status)
LEFT=9
START=2
TAG_STATUS=""
ICONS=("󱂐" "󱂏" "󱂎" "󱂍" "󱂌" "󱂋" "󱂊" "󱂉" "󱂈")
# ICONS=("IX" "VIII" "VII" "VI" "V" "IV" "III" "II" "I")

while [[ "$LEFT" -gt "0" ]]
do
  tag=$(herbstclient tag_status | cut -d '	' -f $START)
  START=$(($START + 1))
  LEFT=$(($LEFT - 1))

  if [[ "$tag" =~ "#" ]];
  then
    echo "${ICONS[$LEFT]}"
    exit
  fi
  continue

  # if [[ "$tag" =~ "#" ]];
  # then
  #   tag=$(echo $tag | tr "#" ' ' | cut -c 2-)
  #   # tag=${ICONS[$LEFT]}
  #   # echo "[$tag]"
  #   TAG_STATUS="$TAG_STATUS[${ICONS[$LEFT]}]"
  #   continue
  # elif [[ "$tag" =~ "-" ]];
  # then
  #   # tag=$(echo $tag | tr "-" ' ' | cut -c 2-)
  #   tag=${ICONS[$LEFT]}
  # elif [[ "$tag" =~ ":" ]];
  # then
  #   # tag=$(echo $tag | tr ":" ' ' | cut -c 2-)
  #   tag=${ICONS[$LEFT]}
  # elif [[ "$tag" =~ "." ]];
  # then
  #   # tag=$(echo $tag | tr "." ' ' | cut -c 2-)
  #   tag=${ICONS[$LEFT]}
  # fi

  # TAG_STATUS="$TAG_STATUS $tag "
done

# echo "- $TAG_STATUS -"
# echo "󰻀 $TAG_STATUS"
# if [[ "${TAG_STATUS:0:1}" == "[" ]]
# then
# else
#   echo "($TAG_STATUS)"
# fi
