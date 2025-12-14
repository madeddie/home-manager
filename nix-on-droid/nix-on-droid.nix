{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    #git
    openssh
    wget
    procps
    killall
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    #man
    gawk
    gnugrep
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  #environment.pathsToLink = [ "/share/bash-completion" ];

  environment.etc."resolv.conf".text = lib.mkForce ''
    # nameserver 1.1.1.1
    nameserver 192.168.0.1
  '';

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  build.extraProotOptions = ["--kill-on-exit"];

  # Set your time zone
  time.timeZone = "America/New_York";

  user.shell = "${pkgs.zsh}/bin/zsh";

  android-integration.termux-setup-storage.enable= true;
}

# vim: ft=nix
