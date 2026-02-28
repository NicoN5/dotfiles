#!/bin/bash

sketchybar --set "$NAME" label="$(ipconfig getifaddr en0)"
