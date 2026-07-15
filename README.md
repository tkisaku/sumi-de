# 墨 de

Minimal Wayland desktop environment built on [river](https://codeberg.org/river/river).

**Includes:** river · waybar · foot · fuzzel · mako · cliphist

## Usage

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager    = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    sumi-de.url     = "github:tkisaku/sumi-de";
  };

  outputs = { nixpkgs, home-manager, sumi-de, ... }: {
    nixosConfigurations.host = nixpkgs.lib.nixosSystem {
      modules = [
        sumi-de.nixosModules.default          # registers river in the display manager session list
        home-manager.nixosModules.homeManager
        {
          home-manager.users.alice.imports = [ sumi-de.homeManagerModules.default ];
        }
      ];
    };
  };
}
```

## Options

All options live under the `sumi-de` namespace in Home Manager.

| Option | Type | Default | Description |
|---|---|---|---|
| `sumi-de.extraAutostart` | `listOf str` | `[]` | Commands appended to the river autostart. Each entry is a full shell command — include `&` to background it. |
| `sumi-de.sunsetMode.enable` | `bool` | `true` | Enable automatic colour-temperature adjustment (gammastep + geoclue2). Location is detected automatically; no coordinates needed. |
| `sumi-de.sunsetMode.temperatureDay` | `int` | `6500` | Colour temperature during the day (Kelvin). |
| `sumi-de.sunsetMode.temperatureNight` | `int` | `3500` | Colour temperature at night (Kelvin). |

## Examples

### Sunset mode (gammastep)

Location is detected automatically via geoclue2 — no coordinates needed.
Also add `sumi-de.nixosModules.default` to your NixOS config to enable the geoclue2 service.

```nix
"sumi-de".sunsetMode = {
  enable = true;
  # temperatureDay   = 6500;  # optional, Kelvin
  # temperatureNight = 3500;
};
```

### Japanese input (fcitx5 + mozc)

```nix
{ pkgs, ... }: {
  imports = [ inputs.sumi-de.homeManagerModules.default ];

  home.packages = with pkgs; [ fcitx5 fcitx5-mozc fcitx5-gtk fcitx5-qt fcitx5-configtool ];

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE  = "fcitx";
    XMODIFIERS    = "@im=fcitx";
  };

  "sumi-de".extraAutostart = [ "fcitx5 --replace -d &" ];
}
```

## Keybindings

| Key | Action |
|---|---|
| `Super + Return` | Terminal (foot) |
| `Super + Space` | Launcher (fuzzel) |
| `Super + B` | Browser (firefox) |
| `Super + V` | Clipboard history |
| `Super + Q` | Close window |
| `Super + F` | Toggle fullscreen |
| `Super + Shift + Space` | Toggle float |
| `Super + J / K` | Focus next / previous |
| `Super + Shift + J / K` | Swap next / previous |
| `Super + H / L` | Shrink / grow main pane |
| `Super + Shift + H / L` | Decrease / increase main count |
| `Super + 1–9` | Switch to tag |
| `Super + Shift + 1–9` | Move window to tag |
| `Super + 0` | Show all tags |
| `Super + Shift + E` | Exit river |
| `Print` | Screenshot selection → clipboard |
| `Super + Print` | Screenshot full screen → clipboard |
| `Super + Shift + N` | Toggle sunset mode on/off (when sunsetMode.enable = true) |
