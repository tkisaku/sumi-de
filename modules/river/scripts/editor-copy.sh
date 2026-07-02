#!/usr/bin/env bash
# Open $EDITOR in a floating foot terminal; copy the result to the clipboard.
tmp=$(mktemp --suffix=.txt)
foot -- "${EDITOR:-nano}" "$tmp"
[ -s "$tmp" ] && wl-copy < "$tmp"
rm -f "$tmp"
