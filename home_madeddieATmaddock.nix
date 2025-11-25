{
  pkgs,
  ...
}: {
  home.username = "madeddie";
  home.homeDirectory = "/home/madeddie";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    TODO_DIR = "$HOME/Documents/notes";
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

#    # TODO split off nvf
#    nvf = {
#      settings.vim = {
#        lsp.enable = true;
#        languages = {
#          enableFormat = true;
#          enableTreesitter = true;
#
#          rust.enable = true;
#          php.enable = true;
#          nix.format.enable = false;
#        };
#      };
#    };
#    claude-code = {
#      enable = true;
#    };
  };

#  fonts = {
#    fontconfig = {
#      enable = true;
#    };
#  };
}
