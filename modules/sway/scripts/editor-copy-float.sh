#!/usr/bin/env bash
# Floats via the floating-editor for_window rule in the sway config.
tmp=$(mktemp --suffix=.txt)
foot --app-id floating-editor -- $EDITOR "$tmp"
[ -s "$tmp" ] && wl-copy < "$tmp"
rm -f "$tmp"
