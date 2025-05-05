{
  config,
  pkgs,
  ...
}: {
  home.username = "Edwin.Hermans";
  home.homeDirectory = "/Users/Edwin.Hermans";
  home.stateVersion = "24.11";

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
        scrollback-limit = 100000
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
    zsh = {
      enableVteIntegration = true;
      profileExtra = "source ~/.orbstack/shell/init.zsh 2>/dev/null || :";
      initContent = ''
        function docker-login {
          if [ -z "$1" ]; then
            export AWS_PROFILE=shared_services
          else
            export AWS_PROFILE=$1
          fi
          aws ecr get-login-password --region "$(aws configure get region)" | docker login --username AWS --password-stdin "$(aws sts get-caller-identity --output text --query Account)".dkr.ecr."$(aws configure get region)".amazonaws.com
        }

        function aws-refresh {
          aws --profile product_dev sso login && docker-login &
          aws --profile curology-main sso login &
        }
      '';
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
