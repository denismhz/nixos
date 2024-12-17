#!/usr/bin/env bash

echo '{ "command": ["get_property", "path"] }' | socat - /tmp/mpvsocket | jq -r '.data'
echo '{ "command": ["get_property", "path"] }' | socat - /tmp/mpvsocket | jq -r '.data' | xargs -I{} rm -f "{}"
