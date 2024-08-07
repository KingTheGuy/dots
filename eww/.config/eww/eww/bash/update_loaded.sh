#!/usr/bin/env bash

SINKS=$(go/sink/main SINKS)
eww update loaded_sinks="$SINKS"

SOURCES=$(go/sink/main SOURCES)
eww update loaded_sources="$SOURCES"

