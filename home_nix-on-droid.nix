{
  config,
  pkgs,
  ...
}: {
  home.username = "nix-on-droid";
  home.homeDirectory = "/data/data/com.termux.nix/files/home";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    TODO_DIR = "$HOME/storage/documents/markor";
  };

  services = {
    gpg-agent = {
      pinentry.package = pkgs.pinentry-curses;
    };
  };
  home.file = {
    "bin" = {
      source = ./dotfiles/nix-on-droid_bin;
      recursive = true;
    };
  };
}
# vim: ft=nix

