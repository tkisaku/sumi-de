#!/usr/bin/env bash

# ── modifier ────────────────────────────────────────────────────────────────
MOD=Super

# ── layout ──────────────────────────────────────────────────────────────────
riverctl default-layout rivertile
rivertile -main-ratio 0.6 -main-count 1 &

# ── apps ────────────────────────────────────────────────────────────────────
RIVER_SCRIPTS="${XDG_CONFIG_HOME:-$HOME/.config}/river/scripts"

riverctl map normal $MOD Return  spawn foot
riverctl map normal $MOD Space   spawn fuzzel
riverctl map normal $MOD B       spawn "$RIVER_SCRIPTS/focus-or-spawn.sh BROWSER_APP_ID BROWSER_CMD"
riverctl map normal $MOD I       spawn "$RIVER_SCRIPTS/editor-copy-float.sh"
riverctl map normal $MOD V       spawn 'cliphist list | fuzzel --dmenu | cliphist decode | wl-copy'

# ── session ─────────────────────────────────────────────────────────────────
riverctl map normal $MOD+Shift E exit

# ── window ──────────────────────────────────────────────────────────────────
riverctl map normal $MOD       Q close
riverctl map normal $MOD       F toggle-fullscreen
riverctl map normal $MOD+Shift Space toggle-float

# ── focus (j/k = next/prev in stack) ────────────────────────────────────────
riverctl map normal $MOD J focus-view next
riverctl map normal $MOD K focus-view previous

# ── swap ────────────────────────────────────────────────────────────────────
riverctl map normal $MOD+Shift J swap next
riverctl map normal $MOD+Shift K swap previous

# ── main ratio (h/l = shrink/grow main pane) ────────────────────────────────
riverctl map normal $MOD H send-layout-cmd rivertile "main-ratio -0.05"
riverctl map normal $MOD L send-layout-cmd rivertile "main-ratio +0.05"

# ── main count ──────────────────────────────────────────────────────────────
riverctl map normal $MOD+Shift H send-layout-cmd rivertile "main-count -1"
riverctl map normal $MOD+Shift L send-layout-cmd rivertile "main-count +1"

# ── tags 1-9 ────────────────────────────────────────────────────────────────
for i in $(seq 1 9); do
  tags=$((1 << (i - 1)))
  riverctl map normal $MOD         "$i" set-focused-tags    $tags
  riverctl map normal $MOD+Shift   "$i" set-view-tags       $tags
  riverctl map normal $MOD+Control "$i" toggle-focused-tags $tags
  riverctl map normal $MOD+Shift+Control "$i" toggle-view-tags $tags
done

# tag 0 = all
all_tags=$(((1 << 32) - 1))
riverctl map normal $MOD       0 set-focused-tags $all_tags
riverctl map normal $MOD+Shift 0 set-view-tags    $all_tags

# ── pointer ─────────────────────────────────────────────────────────────────
riverctl map-pointer normal $MOD BTN_LEFT   move-view
riverctl map-pointer normal $MOD BTN_RIGHT  resize-view
riverctl map-pointer normal $MOD BTN_MIDDLE toggle-float

# ── media ───────────────────────────────────────────────────────────────────
riverctl map normal None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
riverctl map normal None XF86AudioLowerVolume  spawn 'pamixer -d 5'
riverctl map normal None XF86AudioMute         spawn 'pamixer -t'
riverctl map normal None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
riverctl map normal None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
riverctl map normal None XF86AudioPlay         spawn 'playerctl play-pause'
riverctl map normal None XF86AudioNext         spawn 'playerctl next'
riverctl map normal None XF86AudioPrev         spawn 'playerctl previous'

# ── screenshot ──────────────────────────────────────────────────────────────
riverctl map normal None    Print spawn 'grim -g "$(slurp)" - | wl-copy'
riverctl map normal $MOD    Print spawn 'grim - | wl-copy'

# ── appearance — Tokyo Night Storm ───────────────────────────────────────────
riverctl background-color    0x1f2335
riverctl border-color-focused   0x7aa2f7
riverctl border-color-unfocused 0x3b4261
riverctl border-color-urgent    0xf7768e
riverctl border-width 2

# ── input ───────────────────────────────────────────────────────────────────
riverctl set-repeat 50 300

# ── environment — export Wayland vars to systemd/dbus for portal services ───
systemctl --user import-environment WAYLAND_DISPLAY DISPLAY
dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY

# ── autostart ───────────────────────────────────────────────────────────────
. "$(dirname "$0")/autostart.sh"
