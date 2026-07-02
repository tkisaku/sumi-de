{ config, lib, pkgs, ... }:
let
  cfg = config."sumi-de";
in
{
  options."sumi-de".extraAutostart = lib.mkOption {
    type        = lib.types.listOf lib.types.str;
    default     = [];
    description = ''
      Commands appended to the autostart section of the river init.
      Each entry is a complete shell command (include & if you want it
      backgrounded, e.g. "fcitx5 --replace -d &").
    '';
  };

  config = {
    home.packages = [ pkgs.river-classic ];

    xdg.configFile."river/init" = {
      source     = ./scripts/init.sh;
      executable = true;
    };

    xdg.configFile."river/autostart.sh" = {
      text       = (builtins.readFile ./scripts/autostart.sh)
                   + lib.concatMapStrings (cmd: "${cmd}\n") cfg.extraAutostart;
      executable = true;
    };

    xdg.configFile."river/scripts/editor-insert.sh" = {
      source     = ./scripts/editor-insert.sh;
      executable = true;
    };

    xdg.configFile."river/scripts/editor-copy.sh" = {
      source     = ./scripts/editor-copy.sh;
      executable = true;
    };
  };
}
