#!/usr/bin/env bash
tmp=$(mktemp --suffix=.txt)
riverctl rule-add -app-id floating-editor float
foot --app-id floating-editor -- $EDITOR "$tmp"
[ -s "$tmp" ] && wl-copy < "$tmp"
rm -f "$tmp"
sleep 0.2
riverctl rule-del -app-id floating-editor float
