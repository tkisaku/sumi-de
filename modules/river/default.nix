{ pkgs, ... }:
{
  home.packages = [ pkgs.river ];

  xdg.configFile."river/init" = {
    source = ./init;
    executable = true;
  };
}
