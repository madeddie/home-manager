{
  description = "Home Manager configuration of madeddie";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    madeddie-nur = {
      url = "github:madeddie/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    madeddie-nur,
    ...
  }: {
    defaultPackage = {
      aarch64-linux = home-manager.defaultPackage.aarch64-linux;
      aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
    };
    homeConfigurations."edwin@Edwins-MacBook-Air.local" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;

      modules = [
        nvf.homeManagerModules.default
        ./common.nix
        ./home_edwinATEdwins-MacBook-Air.local.nix
      ];
      extraSpecialArgs = {
        inherit madeddie-nur;
      };
    };
    homeConfigurations."nix-on-droid" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-linux;

      modules = [
        nvf.homeManagerModules.default
        ./common.nix
        ./home_nix-on-droid.nix
      ];
      extraSpecialArgs = {
        inherit madeddie-nur;
      };
    };
  };
}
