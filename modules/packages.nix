{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Wayland utilities
    grim        # screenshot (region via slurp)
    slurp       # region selector
    wl-clipboard # clipboard (wl-copy / wl-paste)
    cliphist    # clipboard history
    wtype       # type text into focused window (used by editor-insert)

    ## Audio / brightness
    pamixer
    brightnessctl

    ## Media control
    playerctl

    ## Screen lock / idle
    swaylock
    swayidle
  ];
}
