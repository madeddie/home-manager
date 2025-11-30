{ ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    brews = [
      "mas"
    ];
    casks = [
      "1password"
      "google-chrome"
      "minecraft"
      "moonlight"
      "nvidia-geforce-now"
      "slack"
      "tailscale-app"
      "zoom"
    ];
    masApps = {
      "Apple Configurator" = 1588794674;
    };
  };
}

