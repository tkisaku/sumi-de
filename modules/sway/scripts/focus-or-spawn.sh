#!/usr/bin/env bash
# Focus an existing window by app_id, or spawn the command if not found.
# Usage: focus-or-spawn.sh <app_id> <command> [args...]
APP_ID="$1"; shift
swaymsg -q "[app_id=\"^$APP_ID\$\"] focus" 2>/dev/null || "$@"
