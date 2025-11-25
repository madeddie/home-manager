{ ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    brews = [
      "mas"
      "porter-dev/porter/porter"
    ];
    casks = [
      "1password"
      "google-chrome"
      "minecraft"
      "moonlight"
      "nvidia-geforce-now"
      "slack"
      "tailscale"
      "zoom"
    ];
    masApps = {
      "Apple Configurator" = 1588794674;
    };
  };
}

