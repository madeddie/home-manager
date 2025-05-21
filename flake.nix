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
    sops-nix.url = "github:Mic92/sops-nix";
    simplenote-vim = {
      url = "github:simplenote-vim/simplenote.vim";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    madeddie-nur,
    sops-nix,
    simplenote-vim,
    ...
  }: {
    defaultPackage = {
      aarch64-linux = home-manager.defaultPackage.aarch64-linux;
      aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
    };
    # Personal Macbook Air
    homeConfigurations."edwin@Edwins-MacBook-Air" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;

      modules = [
        nvf.homeManagerModules.default
        sops-nix.homeManagerModules.sops
        ./common.nix
        ./home_edwinATEdwins-MacBook-Air.local.nix
      ];
      extraSpecialArgs = {
        inherit madeddie-nur;
        inherit simplenote-vim;
      };
    };
    # Company Macbook Pro
    homeConfigurations."Edwin.Hermans@Edwin-Hermans-10000385" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;

      modules = [
        nvf.homeManagerModules.default
        sops-nix.homeManagerModules.sops
        ./common.nix
        ./home_Edwin.HermansATEdwin-Hermans-Mac.nix
      ];
      extraSpecialArgs = {
        inherit madeddie-nur;
        inherit simplenote-vim;
      };
    };
    # Personal Android phone
    homeConfigurations."nix-on-droid" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-linux;

      modules = [
        nvf.homeManagerModules.default
        sops-nix.homeManagerModules.sops
        ./common.nix
        ./home_nix-on-droid.nix
      ];
      extraSpecialArgs = {
        inherit madeddie-nur;
        inherit simplenote-vim;
      };
    };
  };
}
