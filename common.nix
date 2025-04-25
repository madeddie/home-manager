{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.bat
    pkgs.devbox
    pkgs.k9s
    pkgs.krew
    pkgs.kubectl
  ];

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

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
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
      autosuggestion.enable = true;
      history.size = 100000;
      history.save = 100000;
      prezto = {
        enable = true;
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
        prompt.theme = "paradox";
      };
    };
    direnv.enable = true;
    git = {
      enable = true;
      userName = "Edwin Hermans";
      userEmail = "edwin@madtech.cx";
      extraConfig = {
        fetch.prune = true;
        pull.ff = "only";
      };
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
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        languages = {
          bash.enable = true;
          go.enable = true;
          lua.enable = true;
          markdown.enable = true;
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
      };
    };
    lazygit.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    gh.enable = true;
    go.enable = true;
    kubecolor = {
      enable = true;
      enableAlias = true;
    };
  };
}
# vim: ft=nix

