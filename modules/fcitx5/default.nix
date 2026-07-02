{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fcitx5
    fcitx5-mozc
    fcitx5-gtk   # GTK IM module (GTK 2/3 apps)
    fcitx5-qt    # Qt IM module  (Qt 5/6 apps)
    fcitx5-configtool
  ];

  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE  = "fcitx";
    XMODIFIERS    = "@im=fcitx";
  };
}
