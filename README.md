# 墨 de

Minimal Wayland desktop environment built on [sway](https://swaywm.org).

**Includes:** sway · waybar · foot · fuzzel · mako · cliphist

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
        sumi-de.nixosModules.default          # registers sway in the display manager session list
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
| `sumi-de.extraAutostart` | `listOf str` | `[]` | Commands appended to the sway autostart. Each entry is a full shell command — include `&` to background it. |
| `sumi-de.sunsetMode.enable` | `bool` | `true` | Enable automatic colour-temperature adjustment (wlsunset). |
| `sumi-de.sunsetMode.sunriseTime` | `str` | `"07:00"` | Sunrise time in HH:MM format. |
| `sumi-de.sunsetMode.sunsetTime` | `str` | `"19:00"` | Sunset time in HH:MM format. |
| `sumi-de.sunsetMode.temperatureDay` | `int` | `6500` | Colour temperature during the day (Kelvin). |
| `sumi-de.sunsetMode.temperatureNight` | `int` | `3500` | Colour temperature at night (Kelvin). |

## Examples

### Sunset mode (wlsunset)

On by default. No internet or location service required — just set your local sunrise/sunset times.

```nix
"sumi-de".sunsetMode = {
  sunriseTime = "06:30";  # optional, default "07:00"
  sunsetTime  = "20:00";  # optional, default "19:00"
  # temperatureDay   = 6500;
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
| `Super + Space` | Launcher (fuzzel) — `Return` focuses the app if already running, `Shift + Return` always launches a new one |
| `Super + B` | Browser (focuses it if already running, on any workspace) |
| `Super + V` | Clipboard history |
| `Super + Q` | Close window |
| `Super + F` | Toggle fullscreen |
| `Super + Shift + Space` | Toggle float |
| `Super + J / K` | Focus next / previous |
| `Super + H / L` | Focus left / right |
| `Super + Shift + H / J / K / L` | Move window left / down / up / right |
| `Super + 1–9` | Switch to workspace |
| `Super + Shift + 1–9` | Move window to workspace |
| `Super + Shift + E` | Exit sway |
| `Print` | Screenshot selection → clipboard |
| `Super + Print` | Screenshot full screen → clipboard |
| `Super + Shift + N` | Toggle sunset mode on/off (when sunsetMode.enable = true) |
