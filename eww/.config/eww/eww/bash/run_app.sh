#!/usr/bin/env bash
eww close launcher

# SELECTED=$(eww get apps | head -1) 

if [[ $1 != "" ]]; then
  SELECTED=$1
  else
  SELECTED=$(eww get apps | head -1) 
fi

exec $SELECTED

