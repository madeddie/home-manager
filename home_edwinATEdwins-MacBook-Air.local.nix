{
  pkgs,
  ...
}: {
  home.username = "edwin";
  home.homeDirectory = "/Users/edwin";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    TODO_DIR = "$HOME/Documents/notes";
  };

  home.packages = with pkgs; ([
    nerd-fonts.droid-sans-mono
    wireguard-go
    wireguard-tools
  ]);

  home.file = {
    ghostty_config = {
      enable = true;
      target = ".config/ghostty/config";
      text = ''
        font-family = DroidSansM Nerd Font
        font-size = 10
        link-url = true
        scrollback-limit = 10000
        macos-titlebar-style = tabs
        maximize = true
        theme = GruvBoxDark
        window-height = 500
        window-width = 500
      '';
    };
  };

  services = {
    gpg-agent = {
      pinentryPackage = pkgs.pinentry_mac;
    };
  };

  programs = {
    java.enable = true;
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
    vscode = {
      enable = true;
      profiles.default = {
        extensions = [
          pkgs.vscode-extensions.jdinhlife.gruvbox
        ];
      };
    };
    ghostty = {
      enable = false;
      settings = {
        font-family = "DroidSansM Nerd Font";
        font-size = 10;
        theme = "GruvBox";
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
          nix.format.enable = false;
        };
      };
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };
}
