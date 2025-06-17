{ ... }: {
  system.primaryUser = "edwin";

  homebrew = {
    casks = [
      "google-chrome"
      "slack"
      "zoom"
    ];
    mas = {
      "Apple Configurator" = 1037126344;
    };
  };
}

