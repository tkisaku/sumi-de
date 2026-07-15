{ pkgs, ... }:
{
  programs.river = {
    enable = true;
    package = pkgs.river-classic;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.geoclue2.enable = true; # required for sunsetMode location detection
}
