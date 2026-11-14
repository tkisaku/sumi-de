#!/usr/bin/env bash

# ── autostart ───────────────────────────────────────────────────────────────
waybar &
mako &
wl-paste --watch cliphist store &
