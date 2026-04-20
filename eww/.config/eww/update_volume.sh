#!/bin/env bash

new_vol=$(($(eww get pro)/100))

eww update pro=$new_vol
# echo $new_vol

wpctl set-volume @DEFAULT_AUDIO_SINK@ $new_vol
