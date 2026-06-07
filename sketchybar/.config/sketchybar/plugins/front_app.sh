#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

MAX=30

front_window_title=$(aerospace list-windows --focused --format '%{app-name} - %{window-title}')
app_bundle_id=$(aerospace list-windows --focused --format '%{app-bundle-id}')
# if ((${#front_window_title} > MAX)); then
#   front_window_title="${front_window_title:0:MAX}…"
# fi
sketchybar --set "$NAME" \
  background.image.drawing='true' \
  background.image.string="app.$app_bundle_id" \
  background.image.scale=0.7 \
  background.image.padding_left=6 \
  label.padding_left=16 \
  label="$front_window_title" \
  label.max_chars=$MAX
