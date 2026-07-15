{ ... }:
{
  _module.args.sumiFont = {
    name = "JetBrainsMono Nerd Font Mono";
    size = 12;
  };

  imports = [
    ./packages.nix
    ./river
    ./foot
    ./fuzzel
    ./waybar
    ./mako.nix
  ];
}
