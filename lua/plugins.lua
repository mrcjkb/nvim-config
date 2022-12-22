-- Bootstrap packer for new installations
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd([[packadd packer.nvim]])
  packer_bootstrap = true
end

return require('packer').startup(function(use)
  use {
    'lewis6991/impatient.nvim',
  }

  use('wbthomason/packer.nvim')

  use {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  }

  -- lazy loaded

  use {
    'toppair/peek.nvim',
    run = 'deno task --quiet build:fast',
    config = function()
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
    -- FIXME
    ft = 'markdown',
  }

  use { 'ellisonleao/glow.nvim', cmd = 'Glow' }

  -- CamelCase, snake_case, etc word motions
  use {
    'chaoren/vim-wordmotion',
    setup = function()
      -- Use Alt as prefix for word motion mappings
      vim.g.wordmotion_mappings = {
        ['w'] = '<M-w>',
        ['b'] = '<M-b>',
        ['e'] = '<M-e>',
        ['ge'] = 'g<M-e>',
        ['aw'] = 'a<M-w>',
        ['iw'] = 'i<M-w>',
        ['<C-R><C-W>'] = '<C-R><M-w>',
      }
    end,
  }

  -- Highlight colours (e.g. #800080)
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      vim.schedule(function()
        require('colorizer').setup()
      end)
    end,
  }

  -- Remaps s [cl] and S [cc] to vertical leap search
  use {
    'ggandor/leap.nvim',
    requires = {
      'ggandor/flit.nvim',
      'tpope/vim-repeat',
    },
    config = function()
      require('leap').add_default_mappings()
      require('flit').setup {}
    end,
  }

  -- User-defined textobjects
  use('kana/vim-textobj-user')

  -- .editorconfig support
  use('gpanders/editorconfig.nvim')

  -- NeoVim clone of Magit
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup {
        integrations = {
          diffview = true,
        },
        mappings = {
          ['a'] = 'Stage',
          ['A'] = 'StageAll',
          ['>'] = 'Toggle',
        },
      }
      vim.keymap.set('n', '<leader>go', neogit.open)
      vim.keymap.set('n', '<leader>gs', function()
        neogit.open { kind = 'split' }
      end)
    end,
  }

  -- Git wrapper
  use('tpope/vim-fugitive')
  use('tpope/vim-rhubarb') -- GitHub fugitive plugin for :GBrowse
  use('tommcdo/vim-fubitive') -- Bitbucket fugitive plugin for :GBrowse
  use {
    'shumphrey/fugitive-gitlab.vim', -- GitLab fugitive support for :GBrowse
    setup = function()
      vim.g.fugitive_gitlab_domains = { 'ssh://gitlab.internal.tiko.ch', 'https://gitlab.internal.tiko.ch' }
    end,
  }

  -- Add repeat . support to custom commands
  use('tpope/vim-repeat')
  -- Navigation with [ and ] keybindings
  use('tpope/vim-unimpaired')
  use {
    'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }, -- lazy-load on specific commands
  }

  use {
    'kylechui/nvim-surround', -- Add 'surroundings text-object cammands'
    config = function()
      require('nvim-surround').setup {}
    end,
  }

  use {
    'folke/persistence.nvim',
    module = 'persistence',
    config = function()
      local p = require('persistence')
      p.setup()
      -- restore the session for the current directory
      vim.keymap.set('n', '<leader>ls', p.load, {})
      -- restore the last session
      vim.keymap.set('n', '<leader>ll', function()
        p.load { last = true }
      end, {})
      -- stop Persistence => session won't be saved on exit
      vim.keymap.set('n', '<leader>ld', p.stop, {})
    end,
  }

  -- Keybindings for commening/uncommenting
  use {
    'numToStr/Comment.nvim',
    config = function()
      vim.schedule(function()
        require('Comment').setup()
      end)
    end,
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('nvim-treesitter.configs').setup {
        context_commentstring = {
          enable = true,
        },
      }
    end,
  }

  use('tommcdo/vim-exchange') -- cx-<motion> or cxx (line)/X (visual) for swapping text objects (cxc to clear)

  -- Material colort theme
  use {
    'marko-cerovac/material.nvim',
    branch = 'main',
    setup = function()
      vim.g.material_style = 'darker'
      vim.g.material_terminal_italics = 1
    end,
    config = function()
      require('theme')
    end,
  }

  -- use {
  --   'vim-test/vim-test',
  --   -- 'git@github.com:MrcJkb/vim-test',
  --   -- branch = 'stacktest-improvements',
  --   setup = function()
  --     vim.g['test#strategy'] = 'neovim'
  --     vim.g['test#java#runner'] = 'gradletest'
  --     vim.g['test#haskell#runner'] = 'stacktest'
  --     -- vim.g['test#haskell#stacktest#file_pattern'] = [[\v^(.*spec.*|.*test.*)\c\.hs$']]
  --   end,
  -- }

  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'MrcJkb/neotest-haskell',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-plenary',
      'rouge8/neotest-rust',
      -- 'nvim-neotest/neotest-vim-test',
    },
    config = function()
      require('neotest-config')
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'MrcJkb/haskell-tools.nvim',
      'simrat39/rust-tools.nvim',
      'simrat39/inlay-hints.nvim',
      'mfussenegger/nvim-jdtls', -- Java LSP support
      'folke/neodev.nvim', -- Lua development for neovim
      -- 'ShinKage/idris2-nvim',
      -- 'MunifTanjim/nui.nvim', -- Required by idris2-nvim

      -- Debug Adapter Protocol
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'jbyuki/one-small-step-for-vimkind', -- Debug Adapter for neovim/lua

      -- Additional plugins used in lsp.lua
      'nvim-lua/lsp-status.nvim', -- LSP status line info
      'ray-x/lsp_signature.nvim', -- LSP autocomplete signature hints
      'camilledejoye/nvim-lsp-selection-range', -- LSP selection range
    },
    config = function()
      require('dap-setup')
      require('lsp')
      -- require('lsp-overrides').setup()
    end,
  }

  use {
    'MrcJkb/lsp-inject.nvim',
  }

  use {
    'kosayoda/nvim-lightbulb',
    setup = function()
      vim.fn.sign_define('LightBulbSign', { text = '', texthl = 'LspDiagnosticsDefaultInformation' })
    end,
    config = function()
      require('nvim-lightbulb').setup {
        autocmd = {
          enabled = true,
          events = { 'CursorHold', 'CursorHoldI', 'CursorMoved', 'TextChanged' },
        },
      }
    end,
  }

  use {
    'hrsh7th/nvim-cmp', -- Completion plugin
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-omni',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'hrsh7th/vim-vsnip', -- VSCode vsnip for use with LSP autocomplete
      'hrsh7th/vim-vsnip-integ',
      'petertriho/cmp-git',
      'lukas-reineke/cmp-rg',
      'onsails/lspkind-nvim', -- Autocomplete icons
      'rcarriga/cmp-dap',
      -- 'amarakon/nvim-cmp-buffer-lines',
      'davidsierradz/cmp-conventionalcommits',
      'dmitmel/cmp-cmdline-history',
    },
    setup = function()
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    end,
    config = function()
      vim.schedule(function()
        require('completion-config')
      end)
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/playground',
      -- 'nvim-treesitter/nvim-treesitter-textobjects',
      'MrcJkb/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    config = function()
      vim.schedule(function()
        require('treesitter-config')
      end)
    end,
  }
  use('p00f/nvim-ts-rainbow') -- Rainbow brackets (needs nvim-treesitter)

  use {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require('lint')
      local hlint_hint_file = os.getenv('HLINT_HINT')
      if hlint_hint_file and hlint_hint_file ~= '' then
        lint.linters.hlint.args = { '--json', '--no-exit-code', '--hint=' .. hlint_hint_file }
      end
      lint.linters_by_ft = {
        haskell = { 'hlint' },
      }
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = vim.api.nvim_create_augroup('lint-commands', {}),
        pattern = { '*.hs' },
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  }

  use {
    'SirVer/ultisnips',
    setup = function()
      vim.g.UltiSnipsSnippetDirectories = { 'UltiSnips', 'ultisnips' }
    end,
  }

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip-config')
    end,
  }

  use {
    'nvim-lua/popup.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    ft = 'lua',
  }

  use {
    -- Project management
    -- Changes the working directory to the project root when you open a file or directory.
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
        patterns = {
          '.git',
          '_darcs',
          '.hg',
          '.bzr',
          '.svn',
          'Makefile',
          'package.json',
          'cabal.project',
          'stack.yaml',
          'hie.yaml',
          'build.gradle',
          'build.grale.kts',
        },
        scope_chdir = 'win',
      }
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      'luc-tielen/telescope_hoogle',
      'MrcJkb/telescope-manix',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-smart-history.nvim',
      'nvim-telescope/telescope-cheat.nvim',
      'tami5/sqlite.lua', -- Required by smart-history and cheat
      'cljoly/telescope-repo.nvim',
      'nvim-lua/plenary.nvim',
    },
    setup = function()
      vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')
    end,
    config = function()
      vim.schedule(function()
        require('telescope-config')
      end)
    end,
  }

  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup()
    end,
  }

  -- proviedes lua scratch pad
  use { 'bfredl/nvim-luadev' }

  -- Fuzzy search
  use {
    'junegunn/fzf',
    run = './install --all',
  }
  use('junegunn/fzf.vim')

  use {
    'junegunn/vim-easy-align', -- Formatting, e.g for formatting markdown tables
    ft = 'markdown',
    setup = function()
      vim.keymap.set('v', '<leader><Bslash>', ':EasyAlign*<Bar><CR>')
    end,
  }

  -- Activate table mode with :TableModeToggle from insert mode
  use {
    'dhruvasagar/vim-table-mode',
    setup = function()
      vim.g.table_mode_corner = '+'
      vim.g.table_mode_corner_corner = '+'
      vim.g.table_mode_header_fillchar = '='
    end,
    ft = 'markdown',
  }

  use {
    'hoob3rt/lualine.nvim', -- Status line at the bottom
    config = function()
      if vim.g.started_by_firenvim then
        vim.cmd('set laststatus=0')
      else
        require('lualine-setup')
      end
    end,
  }

  use {
    'SmiteshP/nvim-gps', -- Status line component that shows context of the current cursor position in the file - used with lualine
  }

  -- rangr client
  use {
    'kevinhwang91/rnvimr',
    setup = function()
      -- Do not make Ranger replace netrw and be the file explorer
      vim.g.rnvimr_ex_enable = 0
      -- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
      vim.g.rnvimr_enable_bw = 1
      vim.keymap.set('t', '<M-i>', '<C-\\><C-n>:RnvimrResize<CR>', { silent = true })
      vim.keymap.set({ 'n', 't' }, '<M-r>', ':RnvimrToggle<CR>', { silent = true })
      -- Map Rnvimr action
      vim.g.rnvimr_action = {
        ['<C-t>'] = 'NvimEdit tabedit',
        ['<C-x>'] = 'NvimEdit split',
        ['<C-v>'] = 'NvimEdit vsplit',
        ['gw'] = 'JumpNvimCwd',
        ['gf'] = 'AttachFile',
        ['yw'] = 'EmitRangerCwd',
      }
    end,
  }

  -- Edit directories in a buffer. :Dirbuf
  use {
    'elihunter173/dirbuf.nvim',
    config = function()
      require('dirbuf').setup {}
    end,
  }

  use('kyazdani42/nvim-web-devicons')
  use('ryanoasis/vim-devicons')

  -- Wrapper for toggling NeoVim terminals
  use {
    'akinsho/toggleterm.nvim',
    config = function()
      vim.schedule(function()
        require('toggleterm-setup')
      end)
    end,
  }

  -- Specify, or on the fly, mark and create persisting key strokes to go to the files you want.
  -- + Unlimiter terminals and navigation
  -- use {
  --   'ThePrimeagen/harpoon',
  --   requires = { 'nvim-lua/plenary.nvim' },
  --   config = function()
  --     require('harpoon-config').setup()
  --   end
  -- }

  use {
    'windwp/nvim-autopairs',
    config = function()
      vim.schedule(function()
        require('autopairs-config')
      end)
    end,
  }

  use {
    -- Tab out form parentheses, quotes, etc.
    'abecodes/tabout.nvim',
  }

  -- Virtual text with git blame information, etc
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.schedule(function()
        require('gitsigns').setup {
          current_line_blame = true,
          current_line_blame_opts = {
            ignore_whitespace = true,
          },
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']g', function()
              if vim.wo.diff then
                return ']g'
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return '<Ignore>'
            end, { expr = true })

            map('n', '[g', function()
              if vim.wo.diff then
                return '[g'
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return '<Ignore>'
            end, { expr = true })

            -- Actions
            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)
            map('n', '<leader>hb', function()
              gs.blame_line { full = true }
            end)
            map('n', '<leader>gb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hD', function()
              gs.diffthis('~')
            end)
            map('n', '<leader>td', gs.toggle_deleted)
            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end,
        }
      end)
    end,
  }

  use {
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end,
    setup = function()
      vim.g.firenvim_config = {
        globalSettings = {
          alt = 'all',
        },
        localSettings = {
          ['https://app.slack.com/'] = { takover = 'never', priority = 1 },
        },
      }
    end,
    config = function()
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('firenvim_gitlab', {}),
        pattern = 'gitlab.internal.tiko.ch_*.txt',
        callback = function()
          vim.cmd('set filetype=markdown')
        end,
      })
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('firenvim_gihub', {}),
        pattern = 'github.com_*.txt',
        callback = function()
          vim.cmd('set filetype=markdown')
        end,
      })
    end,
  }

  use { -- better quickfix list
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  }

  use {
    'mhartington/formatter.nvim',
    config = function()
      local stylish_config = os.getenv('STYLISH_HASKELL_CONFIG')
      local stylish_haskell = require('formatter.filetypes.haskell').stylish_haskell()
      require('formatter').setup {
        filetype = {
          haskell = stylish_config and {
            function()
              return vim.tbl_extend('force', stylish_haskell, {
                args = {
                  '-c',
                  stylish_config,
                },
              })
            end,
          },
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require('formatter.filetypes.lua').stylua,
          },
        },
      }
      local pattern = { '*.lua' }
      if stylish_config then
        table.insert(pattern, '*.hs')
      end
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = vim.api.nvim_create_augroup('post-write-format', {}),
        pattern = pattern,
        command = 'Format',
      })
    end,
  }

  use {
    'gbprod/yanky.nvim',
    config = function()
      require('yanky').setup {
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 500,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      }
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
      vim.keymap.set('n', '<c-n>', '<Plug>(YankyCycleForward)')
      vim.keymap.set('n', '<c-p>', '<Plug>(YankyCycleBackward)')
      vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
    end,
    requires = { 'kkharji/sqlite.lua' },
  }

  use {
    'hkupty/iron.nvim',
    config = function()
      require('repl-setup')
    end,
  }

  use {
    'jbyuki/venn.nvim',
    config = function()
      require('venn')
    end,
  }

  use {
    -- Leverages Neovim's built-in RPC functionality to simplify opening files from
    -- within Neovim's terminal emulator without unintentionally nesting sessions.
    'samjwill/nvim-unception',
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
