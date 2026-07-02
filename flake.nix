{
  description = "墨 de - minimal strokes, maximum expression";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    homeManagerModules.default = import ./modules;
    nixosModules.default = import ./nixos;
  };
}
