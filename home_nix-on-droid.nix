{ config, pkgs, ... }:

{
  home.username = "nix-on-droid";
  home.homeDirectory = "/data/data/com.termux.nix/files/home";
  home.stateVersion = "24.11";

  services = {
    gpg-agent = {
      pinentryPackage = pkgs.pinentry-tty;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}

# vim: ft=nix
