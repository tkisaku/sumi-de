{ sumiFont, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "${sumiFont.name}:size=${toString sumiFont.size}";
      };

      colors = {
        # Tokyo Night Storm
        background = "1f2335";
        foreground = "c0caf5";

        regular0 = "15161e"; # black
        regular1 = "f7768e"; # red
        regular2 = "9ece6a"; # green
        regular3 = "e0af68"; # yellow
        regular4 = "7aa2f7"; # blue
        regular5 = "9d7cd8"; # magenta
        regular6 = "7dcfff"; # cyan
        regular7 = "a9b1d6"; # white

        bright0 = "414868"; # bright black
        bright1 = "f7768e";
        bright2 = "9ece6a";
        bright3 = "e0af68";
        bright4 = "7aa2f7";
        bright5 = "9d7cd8";
        bright6 = "7dcfff";
        bright7 = "c0caf5"; # bright white

        selection-background = "3b4261";
        selection-foreground = "c0caf5";

        cursor = "1f2335 c0caf5";
      };
    };
  };
}
