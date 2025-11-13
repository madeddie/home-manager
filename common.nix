{
  lib,
  config,
  pkgs,
  madeddie-nur,
  simplenote-vim,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  sops = {
    defaultSopsFile = ./secrets/secrets.sops.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
  };
  sops.secrets.simplenote_user = { };
  sops.secrets.simplenote_pass = { };
  sops.secrets.aws_config = {
    sopsFile = ./secrets/aws_config.sops.ini;
    path = "${config.home.homeDirectory}/.aws/config";
    format = "ini";
  };
  sops.secrets.aws_credentials = {
    sopsFile = ./secrets/aws_credentials.sops.ini;
    path = "${config.home.homeDirectory}/.aws/credentials";
    format = "ini";
  };

  home.packages = with pkgs; ([
    bat
    curl
    devbox
    google-cloud-sdk
    jq
    k9s
    krew
    kubectl
    kubeswitch
    nix-prefetch
    nix-update
    nixpkgs-review
    nh
    nvd
    todo-txt-cli
    oci-cli
    pwgen
    ssm-session-manager-plugin
    openhue-cli
  ]);

  home.file  = {
    ".zprezto-prompts" = {
      source = ./dotfiles/zprezto-prompts;
      recursive = true;
    };
  };
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/sops/age/keys.txt";
    TODOTXT_CFG_FILE = "/dev/null";
    TODOTXT_DEFAULT_ACTION = "list";
    TODOTXT_DATE_ON_ADD = 1;
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  home.shellAliases = {
    t = "todo.sh";
    ta = "todo.sh add";
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        max_line_width = 80;
        indent_style = "space";
        indent_size = 2;
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      enableScDaemon = true;
      enableExtraSocket = true;
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      initContent = let
        zshConfigEarlyInit = lib.mkOrder 500 "fpath=($HOME/.zprezto-prompts $fpath)";
        zshConfig = lib.mkOrder 1200 ''
          . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
        '';
      in
        lib.mkMerge [ zshConfigEarlyInit zshConfig ];
      autosuggestion.enable = true;
      history.size = 100000;
      history.save = 100000;
      prezto = {
        enable = true;
        pmoduleDirs = [ "${config.home.homeDirectory}/.zprezto-prompts" ];
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "prompt"
          "git"
          "gpg"
          "ssh"
          "history-substring-search"
          "completion"
        ];
        prompt.theme = "madeddie";
      };
    };
    git = {
      enable = true;
      settings = {
        user.name = "Edwin Hermans";
        user.email = "edwin@madtech.cx";
        fetch.prune = true;
        pull.ff = "only";
      };
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          controlMaster = "auto";
          controlPath = "~/.ssh/master-%r@%n:%p";
          addKeysToAgent = "confirm";
        };
        rbg = {
          host = "rbg rbg.matech.cx";
          user = "madeddie";
          hostname = "rbg.madtech.cx";
          forwardAgent = true;
          localForwards = [
            {
              bind.port = 10004;
              host.address = "localhost";
              host.port = 10004;
            }
            {
              bind.port = 10005;
              host.address = "localhost";
              host.port = 10005;
            }
            {
              bind.port = 10006;
              host.address = "localhost";
              host.port = 10006;
            }
            {
              bind.port = 10010;
              host.address = "localhost";
              host.port = 10010;
            }
            {
              bind.port = 10011;
              host.address = "localhost";
              host.port = 10011;
            }
            {
              bind.port = 10012;
              host.address = "localhost";
              host.port = 10012;
            }
          ];
        };
        home = {
          host = "home home.matech.cx";
          user = "madeddie";
          hostname = "home.madtech.cx";
          forwardAgent = true;
        };
      };
      includes = [
        "~/.orbstack/ssh/config"
      ];
    };
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (
        exts: [
          exts.pass-otp
        ]
      );
    };
    # TODO split off nvf
    nvf = {
      enable = true;
      defaultEditor = true;
      settings.vim = {
        enableLuaLoader = true;
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        assistant = {
          codecompanion-nvim.enable = true;
          copilot.enable = true;
        };
        diagnostics.enable = true;
        autocomplete = {
          nvim-cmp = {
            enable = true;
            sourcePlugins = [
              "codecompanion-nvim"
            ];
          };
        };
        globals = {
          # SimplenoteUsername = "${config.sops.secrets.simplenote_user}";
          # SimplenotePassword = "${config.sops.secrets.simplenote_pass}";
          SimplenoteFiletype = "markdown";
        };
        languages = {
          bash.enable = true;
          go.enable = true;
          lua.enable = true;
          markdown = {
            enable = true;
          };
          nix.enable = true;
          python.enable = true;
        };
        mini = {
          comment.enable = true;
          completion.enable = true;
          icons.enable = true;
          snippets.enable = true;
        };
        utility = {
          diffview-nvim.enable = true;
          snacks-nvim.enable = true;
          surround = {
            enable = true;
            useVendoredKeybindings = false;
          };
        };
        visuals = {
          nvim-web-devicons.enable = true;
        };
        statusline = {
          lualine = {
            enable = true;
            theme = "gruvbox";
          };
        };
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
          transparent = false;
        };
        autopairs.nvim-autopairs.enable = true;
        binds = {
          whichKey.enable = true;
        };
        keymaps = [
          {
            key = "<leader>e";
            action = ":Neotree reveal toggle<CR>";
            mode = "n";
            desc = "Toggle neo-tree";
          }
          {
            key = "<leader>gl";
            action = "<cmd>GitLink<cr>";
            mode = ["n" "v"];
            desc = "Yank git permlink";
          }
          {
            key = "<leader>gL";
            action = "<cmd>GitLink!<cr>";
            mode = ["n" "v"];
            desc = "Open git permlink";
          }
        ];
        telescope.enable = true;

        treesitter.grammars = [pkgs.vimPlugins.nvim-treesitter-parsers.todotxt];
        git = {
          enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        filetree.neo-tree.enable = true;

        # required for simplenote-vim
        withPython3 = true;
        python3Packages = [
          "pynvim"
          "simplenote"
        ];

        extraPlugins = {
          simplenote = {
            package = pkgs.vimUtils.buildVimPlugin { name = "simplenote-vim"; src = simplenote-vim; };
          };
        };
      };
    };
    kubecolor = {
      enable = true;
      enableAlias = true;
    };
    gh = {
      enable = true;
      settings.aliases = {
        mypr = "search prs --author @me --state open";
      };
    };
    tmux = {
      enable = true;
      newSession = true;
      prefix = "C-a";
      keyMode = "vi";
      #sensibleOnTop = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "screen-256color";
      extraConfig = ''
        set -g default-command ${pkgs.zsh}/bin/zsh
      '';
      plugins = with pkgs; [
        tmuxPlugins.extrakto
        tmuxPlugins.fingers
        tmuxPlugins.gruvbox
        tmuxPlugins.pain-control
        tmuxPlugins.tmux-which-key
      ];
    };
    awscli.enable = true;
    direnv.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gh-dash.enable = true;
    go.enable = true;
    gpg.enable = true;
    lazygit.enable = true;
    ripgrep.enable = true;
    claude-code.enable = true;
  };
}
# vim: ft=nix
