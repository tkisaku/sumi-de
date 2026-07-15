{ sumiFont, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "${sumiFont.name}:size=${toString sumiFont.size}";
        terminal = "foot -e";
        layer = "overlay";
        exit-on-keyboard-focus-loss = true;
        width = 30;
        lines = 10;
        prompt = ">";
      };
      colors = {
        background = "1f2335ff";
        text = "c0caf5ff";
        match = "7aa2f7ff";
        selection = "3b4261ff";
        selection-text = "c0caf5ff";
        border = "3d59a1ff";
      };
      border = {
        width = 2;
        radius = 4;
      };
    };
  };
}
