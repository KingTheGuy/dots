#!/bin/bash
 
## THIS IS TOO SLOW SWITCH TO GO

shopt -s nocasematch
defaults="
(eventbox :class 'container'':r run command')
(eventbox :class 'container'':n create note')
"
style() {
  if [[ -z $2 ]];then
    echo "(eventbox :class 'container' '$1')"
  else
    echo "(eventbox :class 'container' :onclick 'notify-send $1' '$1')"
  fi
}

base() {
echo "
(box
  :orientation 'v'
  :space-evenly false
  :spacing {spacing_sub/2}
  :class 'main'
  $1
)
"
}


## HELP COMMAND
if [[ $1 == *":h"* ]];then
  output=""
  output=""$output" $(style ":h list all prefixs")"
  output=""$output" $(style ":r run apps")"
  output=""$output" $(style ":a chat with AI")"
  output=""$output" $(style "..more to come..")"
  eww update content="$(base "$output")"
fi

## RUN COMMAND
if [[ $1 == *":r"* ]];then
  IFS=':' read -r -a paths <<< "$PATH"
  # echo ${paths[@]}
  apps=()
  for path in ${paths[@]}; do
    apps+=($(ls $path))
  done
  # echo ${apps[1]}

   
  # cmd=$(echo "$1" | sed -s 's/:r //')
  cmd=$2
  output=""
  # notify-send "got this: $cmd"
  # for item in $paths; do
  #   if [[ "$item" == *"$cmd"* ]];then
  #     output=""$output" $(style $item)"
  #   fi
  # done

  #this is fucked
  echo $2
  for x in {0..10}; do
    if [[ -z $2 ]];then
      output=""$output" $(style ${apps[$x]})"
      else
        for item in ${apps[@]}; do
          if [[ $2 == *"$item"* ]]; then
            output=""$output" $(style ${apps[$x]})"
          fi
        done
    fi
    # output=""$output" $(style ${apps[$x]})"

  done
  # echo "${apps[k]}"
  eww update content="$(base "$output")"

fi
