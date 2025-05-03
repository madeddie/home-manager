{
  pkgs,
  ...
}: {
  home.username = "Edwin.Hermans";
  home.homeDirectory = "/Users/Edwin.Hermans";
  home.stateVersion = "24.11";

  services = {
    gpg-agent = {
      pinentryPackage = pkgs.pinentry_mac;
    };
  };
}
