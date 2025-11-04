{ ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    brews = [
      "mas"
      "porter-dev/porter/porter"
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

