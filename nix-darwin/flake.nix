{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    # Personal macbook air
    # $ darwin-rebuild build --flake .#Edwins-MacBook-Air
    darwinConfigurations."Edwins-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [ ./edwins-macbook-air.nix ];
    };
    # Company macbook pro
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Edwin-Hermans-Mac
    darwinConfigurations."Edwin-Hermans-Mac" = self.inputs.nix-darwin.lib.darwinSystem {
      modules = [ ./edwin-hermans-mac.nix ];
    };
  };
}
