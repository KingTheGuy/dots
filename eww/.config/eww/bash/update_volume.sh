#!/bin/bash

pro=$(eww get pro)
prev_pro=$(eww get prev_pro)

if [[ "$pro" != "$prev_pro" ]]; then
  exec /home/olrak/.config/eww/go/volume/build/volume
  eww update prev_pro=$pro
fi
