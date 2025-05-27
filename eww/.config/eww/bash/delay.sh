#!/bin/bash

# Check for existing instances
INSTANCE_COUNT=$(pgrep -c -f "$0")

if [ "$INSTANCE_COUNT" -gt 1 ]; then
    # echo "More than one instance of $SCRIPT_NAME is running. Killing the previous instance..."
    pkill -f "$0"
fi


if [[ $# -eq 0 ]];then
  exit
fi

# value=$(eww get $1)

eww update $1="true"

sleep 0.5

eww update $1="false"

# if [[ "$value" == "false" ]]; then
#   eww update $1="true"
# else
#   eww update $1="false"
# fi

