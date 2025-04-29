{
  config,
  pkgs,
  ...
}: {
  home.username = "nix-on-droid";
  home.homeDirectory = "/data/data/com.termux.nix/files/home";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    TODO_DIR = "$HOME/storage/documents/markor";
  };

  services = {
    gpg-agent = {
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
# vim: ft=nix

