{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config."sumi-de";
in
{
  options."sumi-de" = {
    editor = lib.mkOption {
      type = lib.types.str;
      default = "nano";
      description = "Editor command used by Super+I floating scratch buffer.";
    };

    browserLaunchCmd = lib.mkOption {
      type = lib.types.str;
      example = "firefox";
      description = "Browser command launched by Super+B. Must be set by the caller.";
    };

    browserAppId = lib.mkOption {
      type = lib.types.str;
      default = cfg.browserLaunchCmd;
      description = "Wayland app_id used to focus an existing browser window. Defaults to the first word of browserLaunchCmd; override when they differ (e.g. google-chrome-stable → google-chrome).";
    };

    extraAutostart = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        Commands appended to the sway autostart script.
        Each entry is a complete shell command (include & if you want it
        backgrounded, e.g. "fcitx5 --replace -d &").
      '';
    };

    sunsetMode = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable automatic colour-temperature adjustment (wlsunset).";
      };
      sunriseTime = lib.mkOption {
        type = lib.types.str;
        default = "07:00";
        description = "Time of sunrise in HH:MM format.";
      };
      sunsetTime = lib.mkOption {
        type = lib.types.str;
        default = "19:00";
        description = "Time of sunset in HH:MM format.";
      };
      temperatureDay = lib.mkOption {
        type = lib.types.int;
        default = 6500;
        description = "Colour temperature during the day (Kelvin).";
      };
      temperatureNight = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Colour temperature at night (Kelvin).";
      };
    };
  };

  config = {
    home.packages = lib.optional cfg.sunsetMode.enable pkgs.wlsunset;

    xdg.configFile."sway/config".text =
      builtins.replaceStrings [ "BROWSER_APP_ID" "BROWSER_CMD" ] [ cfg.browserAppId cfg.browserLaunchCmd ]
        (builtins.readFile ./config)
      + lib.optionalString cfg.sunsetMode.enable ''
        bindsym $mod+Shift+n exec $scripts/sunset-toggle.sh
      '';

    xdg.configFile."sway/scripts/focus-or-spawn.sh" = {
      source = ./scripts/focus-or-spawn.sh;
      executable = true;
    };

    xdg.configFile."sway/scripts/fuzzel-focus-or-spawn.sh" = {
      source = ./scripts/fuzzel-focus-or-spawn.sh;
      executable = true;
    };

    xdg.configFile."sway/scripts/sunset-toggle.sh" = lib.mkIf cfg.sunsetMode.enable {
      text = ''
        #!/usr/bin/env bash
        if pgrep -x wlsunset > /dev/null; then
          pkill -x wlsunset
        else
          wlsunset -S ${cfg.sunsetMode.sunriseTime} -s ${cfg.sunsetMode.sunsetTime} -T ${toString cfg.sunsetMode.temperatureDay} -t ${toString cfg.sunsetMode.temperatureNight} &
        fi
      '';
      executable = true;
    };

    xdg.configFile."sway/scripts/editor-copy-float.sh" = {
      text =
        builtins.replaceStrings
          [ "foot --app-id floating-editor -- $EDITOR" ]
          [ "foot --app-id floating-editor -- ${cfg.editor}" ]
          (builtins.readFile ./scripts/editor-copy-float.sh);
      executable = true;
    };

    xdg.configFile."sway/autostart.sh" = {
      text =
        (builtins.readFile ./scripts/autostart.sh)
        + lib.optionalString cfg.sunsetMode.enable ''
          wlsunset -S ${cfg.sunsetMode.sunriseTime} -s ${cfg.sunsetMode.sunsetTime} -T ${toString cfg.sunsetMode.temperatureDay} -t ${toString cfg.sunsetMode.temperatureNight} &
        ''
        + lib.concatMapStrings (cmd: "${cmd}\n") cfg.extraAutostart;
      executable = true;
    };
  };
}
