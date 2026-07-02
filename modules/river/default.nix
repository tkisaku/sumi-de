{ config, lib, pkgs, ... }:
let
  cfg = config."sumi-de";

  initText =
    (builtins.readFile ./init)
    + (builtins.readFile ./autostart)
    + lib.concatMapStrings (cmd: "${cmd}\n") cfg.extraAutostart;
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
      text       = initText;
      executable = true;
    };
  };
}
