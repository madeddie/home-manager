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
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # TODO split off nvf
    #nvf = {
    #  settings.vim = {
    #    languages = {
    #      markdown.enable = true;
    #    };
    #  };
    #};
  };
}

# vim: ft=nix
