#!/usr/bin/env bash

playerctl metadata --format '{{ xesam:url }}' | sed -e 's/%20/ /g' -e 's/file\:\/\///g'

rm -f "$(playerctl metadata --format '{{ xesam:url }}' | sed -e 's/%20/ /g' -e 's/file\:\/\///g')"
