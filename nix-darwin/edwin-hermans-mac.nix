{ self, ... }: {
  environment.systemPackages = [];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  environment.pathsToLink = ["/share/zsh"];

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    casks = [
      "arc"
      "ghostty"
      "hammerspoon"
      "hiddenbar"
      "orbstack"
      "protonvpn"
      "sdm"
    ];
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}

