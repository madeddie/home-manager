{ ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    brews = [
      "mas"
      "porter-dev/porter/porter"
    ];
    casks = [
      "1password"
      "1password-cli"
      "betterdisplay"
      "google-chrome"
      "minecraft"
      "nvidia-geforce-now"
      "opencode-desktop"
      "raspberry-pi-imager"
      "slack"
      "tailscale-app"
      "zoom"
    ];
    taps = [
      "porter-dev/porter"
    ];
  };
}

