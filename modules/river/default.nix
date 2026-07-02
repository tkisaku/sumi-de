{ config, lib, pkgs, ... }:
let
  cfg = config."sumi-de";

  envLines = lib.concatStringsSep "\n"
    (lib.mapAttrsToList (k: v: "export ${k}=${lib.escapeShellArg v}")
      cfg.extraSessionVariables);

  initText =
    (builtins.readFile ./init)
    + (lib.optionalString (cfg.extraSessionVariables != {}) ''

      # ── extra environment ────────────────────────────────────────────────────────
      ${envLines}
    '')
    + ''

      # ── autostart ───────────────────────────────────────────────────────────────
      waybar &
      mako &
      wl-paste --watch cliphist store &
    ''
    + lib.concatMapStrings (cmd: "${cmd}\n") cfg.extraAutostart;
in
{
  options."sumi-de" = {
    extraSessionVariables = lib.mkOption {
      type        = lib.types.attrsOf lib.types.str;
      default     = {};
      description = ''
        Environment variables exported in the river init before any process is
        spawned.  All child processes (waybar, apps launched via keybinds, etc.)
        inherit these.  Useful for IM frameworks such as fcitx5.
      '';
    };

    extraAutostart = lib.mkOption {
      type        = lib.types.listOf lib.types.str;
      default     = [];
      description = ''
        Commands appended to the autostart section of the river init.
        Each entry is a complete shell command (include & if you want it
        backgrounded, e.g. "fcitx5 --replace -d &").
      '';
    };
  };

  config = {
    home.packages = [ pkgs.river-classic ];

    xdg.configFile."river/init" = {
      text       = initText;
      executable = true;
    };
  };
}
