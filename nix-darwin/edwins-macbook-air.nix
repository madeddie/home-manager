{ ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    brews = [
      "mas"
    ];
    casks = [
      "google-chrome"
      "slack"
      "zoom"
    ];
    masApps = {
      "Apple Configurator" = 1588794674;
    };
  };
}

