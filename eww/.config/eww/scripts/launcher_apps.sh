#!/usr/bin/env bash
APPS=$(ls /bin/ $HOME/.local/bin/ | grep $2 | tail -n $1)
eww update apps="$APPS"
# echo $APPS
