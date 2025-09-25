{ ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    brews = [
      "mas"
    ];
    casks = [
      "google-chrome"
      "minecraft"
      "moonlight"
      "nvidia-gforce-now"
      "slack"
      "zoom"
    ];
    masApps = {
      "Apple Configurator" = 1588794674;
    };
  };
}

