{ pkgs, ... }:
{
  programs.river = {
    enable = true;
    package = pkgs.river-classic;
  };
}
