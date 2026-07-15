{ sumiFont, ... }:
{
  programs.waybar = {
    enable = true;
    settings = import ./config.nix;
    style = import ./style.nix { inherit sumiFont; };
  };
}
