#!/bin/bash

value=$(eww get $1)
if [[ "$value" == "false" ]]; then
	eww update $1="true"
else
	eww update $1="false"
fi
