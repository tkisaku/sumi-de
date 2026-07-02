[
  {
    layer = "top";
    position = "top";
    height = 28;
    spacing = 4;

    modules-left = [ "river/tags" ];
    modules-center = [ "clock" ];
    modules-right = [ "pulseaudio" "battery" ];

    "river/tags" = {
      num-tags = 9;
    };

    clock = {
      format = "{:%H:%M}";
      tooltip-format = "{:%Y-%m-%d %A}";
      format-alt = "{:%Y-%m-%d}";
    };

    pulseaudio = {
      format = "vol {volume}%";
      format-muted = "vol —";
      on-click = "pamixer -t";
    };

    battery = {
      format = "bat {capacity}%";
      format-charging = "bat {capacity}%↑";
      format-full = "";
      states = {
        warning = 30;
        critical = 15;
      };
    };
  }
]
