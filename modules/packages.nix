{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Wayland utilities
    grim        # screenshot (region via slurp)
    slurp       # region selector
    wl-clipboard # clipboard (wl-copy / wl-paste)
    cliphist    # clipboard history

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
