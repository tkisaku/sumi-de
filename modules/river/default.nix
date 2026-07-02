{ pkgs, ... }:
{
  home.packages = [ pkgs.river-classic ];

  xdg.configFile."river/init" = {
    source = ./init;
    executable = true;
  };
}
