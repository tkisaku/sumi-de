{ config, lib, pkgs, ... }:
let
  cfg = config."sumi-de";
in
{
  options."sumi-de" = {
    editor = lib.mkOption {
      type        = lib.types.str;
      default     = "nano";
      description = "Editor command used by Super+I floating scratch buffer.";
    };

    browser = lib.mkOption {
      type        = lib.types.str;
      default     = "firefox";
      description = "Browser command launched by Super+B.";
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
      text = builtins.replaceStrings
        [ "spawn firefox" ]
        [ "spawn ${cfg.browser}" ]
        (builtins.readFile ./scripts/init.sh);
      executable = true;
    };

    xdg.configFile."river/scripts/editor-copy-float.sh" = {
      text = builtins.replaceStrings
        [ "foot --app-id floating-editor -- nano" ]
        [ "foot --app-id floating-editor -- ${cfg.editor}" ]
        (builtins.readFile ./scripts/editor-copy-float.sh);
      executable = true;
    };

    xdg.configFile."river/autostart.sh" = {
      text       = (builtins.readFile ./scripts/autostart.sh)
                   + lib.concatMapStrings (cmd: "${cmd}\n") cfg.extraAutostart;
      executable = true;
    };
  };
}
