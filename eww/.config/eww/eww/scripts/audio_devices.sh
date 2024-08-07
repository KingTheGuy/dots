#!/usr/bin/env bash
DEVICES=$(pactl list sinks short | cut -f '2' | cut -d '.' -f '1')

echo ${DEVICES[0]}
