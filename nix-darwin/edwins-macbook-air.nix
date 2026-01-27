{ ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    brews = [
      "mas"
    ];
    casks = [
      "1password"
      "1password-cli"
      "droidcam-obs"
      "google-chrome"
      "minecraft"
      "moonlight"
      "nvidia-geforce-now"
      "obs"
      "raspberry-pi-imager"
      "slack"
      "tailscale-app"
      "zoom"
    ];
    masApps = {
      "Apple Configurator" = 1588794674;
    };
  };
}

