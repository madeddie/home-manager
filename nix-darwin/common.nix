{ self, ... }: {
  environment.systemPackages = [];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  environment.pathsToLink = ["/share/zsh"];

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    greedyCasks = true;
    casks = [
      "arc"
      "ghostty"
      "hammerspoon"
      "hiddenbar"
      "menubarx"
      "minecraft"
      "nvidia-geforce-now"
      "orbstack"
      "protonvpn"
    ];
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.mouse.tapBehavior" = 1;
    };
    dock = {
      autohide = true;
      magnification = true;
      wvous-br-corner = 14; # bottom-right corner quick note
    };
    finder = {
      #AppleShowAllExtensions = true;
      #AppleShowAllFiles = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      ShowStatusBar = true;
      _FXSortFoldersFirst = true;
    };
  };
}

