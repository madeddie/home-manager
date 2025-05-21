{ self, ... }: {
  system.primaryUser = "Edwin.Hermans";

  homebrew = {
    casks = [
      "sdm"
    ];
  };
}

