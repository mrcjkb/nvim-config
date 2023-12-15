{inputs}: final: prev:
with final.lib; let
  mkNeovim = {
    appName ? null,
    wrapRc ? true,
    plugins ? [],
    devPlugins ? [],
    extraPackages ? [],
    resolvedExtraLuaPackages ? [],
    extraPython3Packages ? p: [],
    withPython3 ? true,
    withRuby ? false,
    withNodeJs ? false,
    viAlias ? true,
    vimAlias ? true,
  }: let
    defaultPlugin = {
      plugin = null;
      config = null;
      optional = false;
      runtime = {};
    };

    externalPackages = extraPackages ++ [final.sqlite];

    normalizedPlugins = map (x:
      defaultPlugin
      // (
        if x ? plugin
        then x
        else {plugin = x;}
      ))
    plugins;

    neovimConfig = final.neovimUtils.makeNeovimConfig {
      inherit extraPython3Packages withPython3 withRuby withNodeJs viAlias vimAlias;
      plugins = normalizedPlugins;
    };

    customRC =
      ''
        vim.loader.enable()
        vim.opt.rtp:prepend('${../lib}')
      ''
      + (builtins.readFile ../nvim/init.lua)
      + neovimConfig.neovimRcContent
      + optionalString (devPlugins != []) (
        ''
          local dev_pack_path = vim.fn.stdpath('data') .. '/site/pack/dev'
          local dev_plugins_dir = dev_pack_path .. '/opt'
          local dev_plugin_path
        ''
        + strings.concatMapStringsSep
        "\n"
        (plugin: ''
          dev_plugin_path = dev_plugins_dir .. '/${plugin.name}'
          if vim.fn.empty(vim.fn.glob(dev_plugin_path)) > 0 then
            vim.notify('Bootstrapping dev plugin ${plugin.name} ...', vim.log.levels.INFO)
            vim.cmd('!${final.git}/bin/git clone ${plugin.url} ' .. dev_plugin_path)
          end
          vim.cmd('packadd! ${plugin.name}')
        '')
        devPlugins
      )
      + ''
        vim.opt.rtp:append('${../nvim}')
      '';

    extraMakeWrapperArgs = builtins.concatStringsSep " " (
      (optional (appName != "nvim" && appName != null && appName != "")
        ''--set NVIM_APPNAME "${appName}"'')
      ++ (optional (externalPackages != [])
        ''--prefix PATH : "${makeBinPath externalPackages}"'')
      ++ (optional wrapRc
        ''--add-flags -u --add-flags "${final.writeText "init.lua" customRC}"'')
      ++ [
        ''--set LIBSQLITE_CLIB_PATH "${final.sqlite.out}/lib/libsqlite3.so"''
        ''--set LIBSQLITE "${final.sqlite.out}/lib/libsqlite3.so"''
      ]
    );

    extraMakeWrapperLuaCArgs = optionalString (resolvedExtraLuaPackages != []) ''
      --suffix LUA_CPATH ";" "${
        lib.concatMapStringsSep ";" final.luaPackages.getLuaCPath
        resolvedExtraLuaPackages
      }"'';

    extraMakeWrapperLuaArgs =
      optionalString (resolvedExtraLuaPackages != [])
      ''
        --suffix LUA_PATH ";" "${
          concatMapStringsSep ";" final.luaPackages.getLuaPath
          resolvedExtraLuaPackages
        }"'';
  in
    # final.wrapNeovimUnstable inputs.packages.${prev.system}.neovim (neovimConfig
    final.wrapNeovimUnstable final.neovim-nightly (neovimConfig
      // {
        wrapperArgs =
          escapeShellArgs neovimConfig.wrapperArgs
          + " "
          + extraMakeWrapperArgs
          + " "
          + extraMakeWrapperLuaCArgs
          + " "
          + extraMakeWrapperLuaArgs;
        wrapRc = false;
      });

  all-plugins = with final.nvimPlugins;
    ([
        plenary
        sqlite
        nvim-web-devicons
        diffview
        nvim-ts-context-commentstring
        treesitter-playground
        treesitter-textobjects
        treesitter-context
        treesitter-refactor
        wildfire-nvim
        rainbow-delimiters-nvim
        vim-matchup
        iswap-nvim
        nvim-treesitter
        vim-wordmotion
        nvim-highlight-colors
        # (withConfig leap "require('leap').set_default_keymaps()")
        flash-nvim
        eyeliner-nvim
        vim-textobj-user
        neogit
        gitlinker
        repeat
        unimpaired
        surround
        persistence
        nvim-lastplace
        comment
        material-theme
        neotest-rust
        neotest
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
        neodev-nvim
        jdtls
        lsp-status
        lsp_signature
        nvim-lsp-selection-range
        nvim-lightbulb
        fidget
        illuminate
        neoconf-nvim
        schemastore-nvim
        lspconfig
        lspkind-nvim
        nvim-code-action-menu
        nvim-lint
        project
        telescope_hoogle
        telescope-smart-history
        telescope
        todo-comments
        fzf-lua
        nvim-navic
        lualine
        rnvimr
        toggleterm
        harpoon
        gitsigns
        nvim-bqf
        formatter
        yanky
        promise-async
        nvim-ufo
        statuscol
        nvim-unception
        tmux-nvim
        hardtime-nvim
        term-edit-nvim
        oil-nvim
        other-nvim
        wf-nvim
        which-key-nvim
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
        # cmp-omni
        cmp-luasnip
        cmp-luasnip-choice
        cmp-git
        cmp-rg
        cmp-dap
        nvim-cmp
      ])
    ++ (with prev.vimPlugins; [
      luasnip
      markdown-preview-nvim
      vim-fugitive
      telescope-fzy-native-nvim
      neorg
    ]);

  extraPackages = with final; [
    haskellPackages.fast-tags
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-json-languageserver-bin
    nodePackages.bash-language-server
    taplo # toml toolkit including a language server
    sqls
  ];

  nvim-dev = mkNeovim {
    plugins = all-plugins;
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
      {
        name = "rustaceanvim";
        url = "git@github.com:mrcjkb/rustaceanvim.git";
      }
    ];
    inherit extraPackages;
  };

  nvim-pkg = mkNeovim {
    plugins =
      all-plugins
      ++ (with final; [
        haskell-tools-nvim-dev
        haskell-snippets-nvim
        neotest-haskell-dev
        telescope-manix
        rustaceanvim
      ]);
    inherit extraPackages;
  };
in {
  inherit
    nvim-dev
    nvim-pkg
    ;
}
