#!/usr/bin/env bash
# Open $EDITOR in a floating foot terminal; type the result into the focused window.
tmp=$(mktemp --suffix=.txt)
foot -- "${EDITOR:-nano}" "$tmp"
[ -s "$tmp" ] && wtype - < "$tmp"
rm -f "$tmp"
