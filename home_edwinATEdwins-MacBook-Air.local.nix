{
  config,
  pkgs,
  ...
}: {
  home.username = "edwin";
  home.homeDirectory = "/Users/edwin";
  home.stateVersion = "24.11";

  services = {
    gpg-agent = {
      pinentryPackage = pkgs.pinentry_mac;
    };
  };

  programs = {
    zsh = {
      enableVteIntegration = true;
      profileExtra = "source ~/.orbstack/shell/init.zsh 2>/dev/null || :";
      prezto = {
        pmodules = [
          "docker"
          "homebrew"
        ];
      };
    };
    # TODO split off nvf
    nvf = {
      settings.vim = {
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;

          rust.enable = true;
          php.enable = true;
        };
      };
    };
  };
}
