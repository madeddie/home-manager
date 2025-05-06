{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }:
  {
    # Personal macbook air
    # $ darwin-rebuild build --flake .#Edwins-MacBook-Air
    darwinConfigurations."Edwins-MacBook-Air" = self.inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ./common.nix
        ./edwins-macbook-air.nix
      ];
      specialArgs = {inherit self;};
    };
    # Company macbook pro
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Edwin-Hermans-Mac
    darwinConfigurations."Edwin-Hermans-Mac" = self.inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ./common.nix
        ./edwin-hermans-mac.nix
      ];
      specialArgs = {inherit self;};
    };
  };
}
