#!/usr/bin/env bash
# Super+Space launcher. Return focuses the chosen app if it is already running
# (otherwise launches it); Shift+Return (fuzzel custom-1, exit code 10) always
# launches a new instance.
#
# fuzzel runs the chosen app through --launch-prefix before it exits, so the
# prefix (this same script, with FUZZEL_LAUNCH_STATE set) only records the
# Desktop File ID and command line. The decision is made here once fuzzel's
# exit code tells which key was pressed.
if [ -n "$FUZZEL_LAUNCH_STATE" ]; then
  printf '%s\0' "$DESKTOP_ENTRY_ID" "$@" > "$FUZZEL_LAUNCH_STATE.tmp"
  mv "$FUZZEL_LAUNCH_STATE.tmp" "$FUZZEL_LAUNCH_STATE"
  exit 0
fi

state="${XDG_RUNTIME_DIR:-/tmp}/fuzzel-launch"
rm -f "$state"
FUZZEL_LAUNCH_STATE="$state" fuzzel --launch-prefix="$0"
status=$?
[ "$status" -eq 0 ] || [ "$status" -eq 10 ] || exit 0

# fuzzel does not wait for the prefix to finish
for _ in $(seq 20); do
  [ -f "$state" ] && break
  sleep 0.05
done
[ -f "$state" ] || exit 0
mapfile -d '' -t entry < "$state"
rm -f "$state"
desktop_id="${entry[0]}"
cmd=("${entry[@]:1}")

[ "$status" -eq 10 ] && exec "${cmd[@]}"

app_ids=()
IFS=: read -ra data_dirs <<< "${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
for dir in "${XDG_DATA_HOME:-$HOME/.local/share}" "${data_dirs[@]}"; do
  file="$dir/applications/$desktop_id"
  if [ -f "$file" ]; then
    wm_class=$(sed -n 's/^StartupWMClass=//p' "$file" | head -n 1)
    [ -n "$wm_class" ] && app_ids+=("$wm_class")
    break
  fi
done
[ -n "$desktop_id" ] && app_ids+=("${desktop_id%.desktop}")

for app_id in "${app_ids[@]}"; do
  swaymsg -q "[app_id=\"^$app_id\$\"] focus" 2>/dev/null && exit 0
done
exec "${cmd[@]}"
