#!/usr/bin/env bash

players=$(playerctl -l)

for ply in $players;do
  echo $ply
done
