{
  description = "墨 de - minimal strokes, maximum expression";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeManagerModules.default = import ./modules;

      packages.${system}.default =
        (home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            self.homeManagerModules.default
            {
              home.username = "tk";
              home.homeDirectory = "/home/tk";
              home.stateVersion = "24.11";
            }
          ];
        }).activationPackage;
    };
}
