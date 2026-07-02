{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fcitx5
    fcitx5-mozc
    fcitx5-configtool
  ];

  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE  = "fcitx";
    XMODIFIERS    = "@im=fcitx";
  };
}
