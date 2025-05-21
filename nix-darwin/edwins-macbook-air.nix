{ self, ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    casks = [
      "google-chrome"
      "slack"
      "zoom"
    ];
  };
}

