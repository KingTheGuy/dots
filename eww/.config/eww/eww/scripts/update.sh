#!/usr/bin/env bash

# update packages

sudo xbps-install -uy xbps &&
sudo xbps-install -Syyu &&
eww update packages_to_update=$(xbps-install -Mun | wc -l)
