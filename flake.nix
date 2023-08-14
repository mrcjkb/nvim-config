{
  description = "Neovim config";

  nixConfig = {
    extra-substituters = "https://mrcjkb.cachix.org";
    extra-trusted-public-keys = "mrcjkb.cachix.org-1:KhpstvH5GfsuEFOSyGjSTjng8oDecEds7rbrI96tjA4=";
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";

    # Plugins
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    sqlite = {
      url = "github:kkharji/sqlite.lua";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    diffview = {
      url = "github:sindrets/diffview.nvim";
      flake = false;
    };
    peek = {
      url = "github:toppair/peek.nvim";
      flake = false;
    };
    glow = {
      url = "github:ellisonleao/glow.nvim";
      flake = false;
    };
    vim-wordmotion = {
      # Vimscript
      url = "github:chaoren/vim-wordmotion";
      flake = false;
    };
    colorizer = {
      url = "github:NvChad/nvim-colorizer.lua";
      flake = false;
    };
    # leap = {
    #   url = "github:ggandor/leap.nvim";
    #   flake = false;
    # };
    flash-nvim = {
      url = "github:folke/flash.nvim";
      flake = false;
    };
    eyeliner-nvim = {
      url = "github:jinh0/eyeliner.nvim";
      flake = false;
    };
    vim-textobj-user = {
      # Vimscript
      # User-defined textobjects
      url = "github:kana/vim-textobj-user";
      flake = false;
    };
    neogit = {
      url = "github:NeogitOrg/neogit";
      flake = false;
    };
    gitlinker = {
      url = "github:ruifm/gitlinker.nvim";
      flake = false;
    };
    repeat = {
      url = "github:tpope/vim-repeat";
      flake = false;
    };
    unimpaired = {
      # bracket mappings
      url = "github:tpope/vim-unimpaired";
      flake = false;
    };
    surround = {
      url = "github:kylechui/nvim-surround";
      flake = false;
    };
    persistence = {
      url = "github:folke/persistence.nvim";
      flake = false;
    };
    comment = {
      url = "github:numToStr/Comment.nvim";
      flake = false;
    };
    material-theme = {
      url = "github:marko-cerovac/material.nvim";
      flake = false;
    };
    neotest = {
      url = "github:nvim-neotest/neotest";
      flake = false;
    };
    neotest-python = {
      url = "github:nvim-neotest/neotest-python";
      flake = false;
    };
    neotest-plenary = {
      url = "github:nvim-neotest/neotest-plenary";
      flake = false;
    };
    neotest-rust = {
      url = "github:rouge8/neotest-rust";
      flake = false;
    };
    neoconf-nvim = {
      url = "github:folke/neoconf.nvim";
      flake = false;
    };
    schemastore-nvim = {
      url = "github:b0o/SchemaStore.nvim";
      flake = false;
    };
    lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    rust-tools = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    inlay-hints = {
      url = "github:simrat39/inlay-hints.nvim";
      flake = false;
    };
    jdtls = {
      # FIXME: Update setup in dotfiles
      url = "github:mfussenegger/nvim-jdtls";
      flake = false;
    };
    neodev-nvim = {
      url = "github:folke/neodev.nvim";
      flake = false;
    };
    diagflow-nvim = {
      url = "github:dgagn/diagflow.nvim";
      flake = false;
    };
    femaco = {
      url = "github:AckslD/nvim-FeMaco.lua";
      flake = false;
    };
    nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };
    nvim-dap-ui = {
      url = "github:rcarriga/nvim-dap-ui";
      flake = false;
    };
    nvim-dap-virtual-text = {
      url = "github:theHamsta/nvim-dap-virtual-text";
      flake = false;
    };
    lsp-status = {
      url = "github:nvim-lua/lsp-status.nvim";
      flake = false;
    };
    lsp_signature = {
      url = "github:ray-x/lsp_signature.nvim";
      flake = false;
    };
    nvim-lsp-selection-range = {
      url = "github:camilledejoye/nvim-lsp-selection-range";
      flake = false;
    };
    nvim-lightbulb = {
      url = "github:kosayoda/nvim-lightbulb";
      flake = false;
    };
    fidget = {
      url = "git+https://github.com/j-hui/fidget.nvim.git?ref=legacy";
      flake = false;
    };
    illuminate = {
      url = "github:RRethy/vim-illuminate";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-tmux = {
      url = "github:andersevenrud/cmp-tmux";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    cmp-cmdline-history = {
      url = "github:dmitmel/cmp-cmdline-history";
      flake = false;
    };
    cmp-nvim-lua = {
      url = "github:hrsh7th/cmp-nvim-lua";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-nvim-lsp-document-symbol = {
      url = "github:hrsh7th/cmp-nvim-lsp-document-symbol";
      flake = false;
    };
    cmp-nvim-lsp-signature-help = {
      url = "github:hrsh7th/cmp-nvim-lsp-signature-help";
      flake = false;
    };
    cmp-omni = {
      url = "github:hrsh7th/cmp-omni";
      flake = false;
    };
    cmp-luasnip = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };
    cmp-git = {
      url = "github:petertriho/cmp-git";
      flake = false;
    };
    cmp-rg = {
      url = "github:lukas-reineke/cmp-rg";
      flake = false;
    };
    lspkind-nvim = {
      # vscode-style completion pictograms
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };
    nvim-code-action-menu = {
      url = "github:weilbith/nvim-code-action-menu";
      flake = false;
    };
    cmp-dap = {
      url = "github:rcarriga/cmp-dap";
      flake = false;
    };
    treesitter-playground = {
      url = "github:nvim-treesitter/playground";
      flake = false;
    };
    treesitter-textobjects = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects";
      flake = false;
    };
    treesitter-context = {
      url = "github:nvim-treesitter/nvim-treesitter-context";
      flake = false;
    };
    nvim-ts-context-commentstring = {
      url = "github:JoosepAlviste/nvim-ts-context-commentstring";
      flake = false;
    };
    treesitter-refactor = {
      url = "github:nvim-treesitter/nvim-treesitter-refactor";
      flake = false;
    };
    rainbow-delimiters-nvim = {
      url = "github:hiphish/rainbow-delimiters.nvim";
      flake = false;
    };
    vim-matchup = {
      # tree-sitter powered % motions
      # url = "github:andymass/vim-matchup";
      url = "github:mrcjkb/vim-matchup/mrcjkb/haskell-queries";
      flake = false;
    };
    nvim-lint = {
      url = "github:mfussenegger/nvim-lint";
      flake = false;
    };
    luasnip = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };
    project = {
      url = "github:ahmedkhalf/project.nvim";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim/0.1.x";
      flake = false;
    };
    telescope_hoogle = {
      url = "github:luc-tielen/telescope_hoogle";
      flake = false;
    };
    telescope-smart-history = {
      url = "github:nvim-telescope/telescope-smart-history.nvim";
      flake = false;
    };
    todo-comments = {
      url = "github:folke/todo-comments.nvim";
      flake = false;
    };
    fzf-lua = {
      url = "github:ibhagwan/fzf-lua";
      flake = false;
    };
    lualine = {
      url = "github:hoob3rt/lualine.nvim";
      flake = false;
    };
    nvim-gps = {
      url = "github:SmiteshP/nvim-gps";
      flake = false;
    };
    rnvimr = {
      url = "github:kevinhwang91/rnvimr";
      flake = false;
    };
    mini-files = {
      url = "github:echasnovski/mini.files";
      flake = false;
    };
    toggleterm = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
    harpoon = {
      url = "github:ThePrimeagen/harpoon";
      flake = false;
    };
    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    nvim-bqf = {
      url = "github:kevinhwang91/nvim-bqf";
      flake = false;
    };
    formatter = {
      url = "github:mhartington/formatter.nvim";
      flake = false;
    };
    yanky = {
      url = "github:gbprod/yanky.nvim";
      flake = false;
    };
    iron = {
      url = "github:hkupty/iron.nvim";
      flake = false;
    };
    promise-async = {
      # XXX: Is this a dependency?
      url = "github:kevinhwang91/promise-async";
      flake = false;
    };
    nvim-ufo = {
      url = "github:kevinhwang91/nvim-ufo";
      flake = false;
    };
    statuscol = {
      url = "github:luukvbaal/statuscol.nvim";
      flake = false;
    };
    nvim-unception = {
      # Prevent nested neovim instances
      url = "github:samjwill/nvim-unception";
      flake = false;
    };
    tmux-nvim = {
      url = "github:aserowy/tmux.nvim";
      flake = false;
    };
    hardtime-nvim = {
      url = "github:m4xshen/hardtime.nvim";
      flake = false;
    };
    term-edit-nvim = {
      url = "github:chomosuke/term-edit.nvim";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    neovim-nightly-overlay,
    flake-utils,
    pre-commit-hooks,
    ...
  }: let
    supportedSystems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    plugin-overlay = import ./nix/plugin-overlay.nix {inherit inputs;};
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          neovim-nightly-overlay.overlay
        ];
      };
      shell = pkgs.mkShell {
        name = "nvim-config-devShell";
        buildInputs = with pre-commit-hooks.packages.${system}; [
          lua-language-server
          alejandra
          stylua
          luacheck
        ];
        shellHook = ''
          ${self.checks.${system}.pre-commit-check.shellHook}
        '';
      };
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = self;
        hooks = {
          alejandra.enable = true;
          stylua.enable = true;
          luacheck.enable = true;
        };
      };
    in {
      packages = rec {
        default = neovim-nightly;
        inherit (pkgs) neovim-nightly;
      };
      devShells = {
        default = shell;
      };
      checks = {
        inherit pre-commit-check;
      };
    })
    // {
      nixosModules.default = {
        pkgs,
        lib,
        defaultUser,
        ...
      }: {
        imports = [
          ./nix/nvim_module.nix
        ];
        programs.nvim = let
          schedule = config: ''
            vim.schedule(function()
              ${config}
            end)
          '';
          withConfig = plugin: config: {
            inherit plugin config;
          };
          withLuaModule = plugin: module: withConfig plugin "require('${module}')";
          withScheduledLuaModule = plugin: module: withConfig plugin (schedule "require('${module}')");
          withLuaSetup = plugin: module: withConfig plugin "require('${module}').setup()";
          withDefaultLuaSetup = plugin: module: withConfig plugin "require('${module}').setup {}";
          withScheduledLuaSetup = plugin: module: withConfig plugin (schedule "require('${module}').setup()");
        in {
          enable = true;
          defaultEditor = true;
          package = pkgs.neovim-nightly;
          vimAlias = true;
          viAlias = true;
          vimdiffAlias = true;
          withNodeJs = true;
          withRuby = true;
          withPython3 = true;
          # extraPython3Packages = ps:
          #   with ps; [
          #     pynvim
          #     python-lsp-server
          #     pylsp-mypy
          #     flake8
          #   ];
          extraPackages = with pkgs; [
            (python3.withPackages (ps:
              with ps; [
                pynvim
                python-lsp-server
                pylsp-mypy
                flake8
                ueberzug
              ]))
            haskellPackages.fast-tags # Fast tag generation
            glow # Dependency of glow.nvim
            bat
            ueberzug # Display images in terminal
            feh # Fast and light image viewer
            fzf # Fuzzy search
            ripgrep
            silver-searcher # Ag
            fd
            ctags
          ];
          extraConfigLua = ''
            require('mrcjk')
          '';
          devPlugins = [
            {
              name = "haskell-tools.nvim";
              url = "git@github.com:mrcjkb/haskell-tools.nvim.git";
            }
            {
              name = "neotest-haskell";
              url = "git@github.com:mrcjkb/neotest-haskell.git";
            }
            {
              name = "haskell-snippets.nvim";
              url = "git@github.com:mrcjkb/haskell-snippets.nvim.git";
            }
            {
              name = "telescope-manix";
              url = "git@github.com:mrcjkb/telescope-manix.git";
            }
          ];
          plugins = with pkgs.nvimPlugins;
            [
              plenary
              (withConfig sqlite "vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')")
              nvim-web-devicons
              (withLuaModule diffview "plugin.diffview")
              nvim-ts-context-commentstring
              treesitter-playground
              treesitter-textobjects
              treesitter-context
              treesitter-refactor
              rainbow-delimiters-nvim
              vim-matchup
              (withLuaModule pkgs.vimPlugins.nvim-treesitter.withAllGrammars "plugin.treesitter")
              # TODO: Package with deno build
              (withLuaModule peek "plugin.peek")
              glow # TODO: Add glow dependency to overlay
              (withLuaModule vim-wordmotion "plugin.wordmotion")
              (withScheduledLuaSetup colorizer "colorizer")
              # (withConfig leap "require('leap').set_default_keymaps()")
              (withLuaModule flash-nvim "plugin.flash")
              (withLuaModule eyeliner-nvim "plugin.eyeliner")
              vim-textobj-user
              pkgs.vimPlugins.vim-fugitive
              (withLuaModule neogit "plugin.neogit")
              (withLuaModule gitlinker "plugin.gitlinker")
              repeat
              unimpaired
              (withLuaSetup surround "nvim-surround")
              (withLuaModule persistence "plugin.persistence")
              (withLuaSetup comment "Comment")
              (withLuaModule material-theme "plugin.theme")
              neotest-python
              neotest-plenary
              neotest-rust
              (withLuaModule neotest "plugin.neotest")
              (withLuaModule nvim-dap "plugin.dap")
              nvim-dap-ui
              nvim-dap-virtual-text
              (withLuaModule neodev-nvim "plugin.neodev")
              (withLuaModule diagflow-nvim "plugin.diagflow")
              (withLuaModule femaco "plugin.femaco")
              jdtls
              lsp-status
              lsp_signature
              nvim-lsp-selection-range
              nvim-lightbulb
              rust-tools
              inlay-hints
              fidget
              illuminate
              (withLuaSetup neoconf-nvim "neoconf")
              schemastore-nvim
              lspconfig
              lspkind-nvim
              nvim-code-action-menu
              (withLuaModule nvim-lint "plugin.lint")
              (withLuaModule luasnip "plugin.luasnip")
              (withLuaModule project "plugin.project")
              telescope_hoogle
              pkgs.vimPlugins.telescope-fzy-native-nvim
              telescope-smart-history
              (withScheduledLuaModule telescope "plugin.telescope")
              (withLuaSetup todo-comments "todo-comments")
              fzf-lua
              nvim-gps
              (withLuaModule lualine "plugin.lualine")
              (withLuaModule rnvimr "plugin.rnvimr")
              (withLuaModule toggleterm "plugin.toggleterm")
              (withLuaModule harpoon "plugin.harpoon")
              (withLuaModule gitsigns "plugin.gitsigns")
              nvim-bqf
              (withLuaModule formatter "plugin.formatter")
              (withLuaModule yanky "plugin.yanky")
              (withLuaModule iron "plugin.repl")
              promise-async
              (withLuaModule nvim-ufo "plugin.ufo")
              (withLuaModule statuscol "plugin.statuscol")
              nvim-unception
              (withDefaultLuaSetup tmux-nvim "tmux")
              (withLuaModule hardtime-nvim "plugin.hardtime")
              (withLuaModule term-edit-nvim "plugin.term-edit")
              (withLuaModule mini-files "plugin.files")
            ]
            ++ [
              # nvim-cmp and plugins
              cmp-buffer
              cmp-tmux
              cmp-path
              cmp-cmdline
              cmp-cmdline-history
              cmp-nvim-lua
              cmp-nvim-lsp
              cmp-nvim-lsp-document-symbol
              cmp-nvim-lsp-signature-help
              cmp-omni
              cmp-luasnip
              cmp-git
              cmp-rg
              cmp-dap
              (withScheduledLuaModule nvim-cmp "plugin.completion")
            ];
        };
        home-manager.sharedModules = [
          {
            xdg.configFile."nvim" = {
              source = ./nvim;
              recursive = true;
            };
          }
        ];

        nixpkgs = {
          overlays = [
            neovim-nightly-overlay.overlay
            plugin-overlay
          ];
        };

        environment = with pkgs; {
          sessionVariables = rec {
            LIBSQLITE_CLIB_PATH = "${sqlite.out}/lib/libsqlite3.so";
            LIBSQLITE = LIBSQLITE_CLIB_PATH; # Expected by sqlite plugin
          };
        };
      };
    };
}
