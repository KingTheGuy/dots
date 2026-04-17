#!/bin/env bash

value=$(eww get pro)
amount=2
dir=$1
if [[ "$dir" == "down" ]]; then
	amount=-$amount
fi

new_value=$((value + amount))
eww update pro=$new_value
