local cmd = vim.cmd
local fn = vim.fn
local opt = vim.o
local keymap = vim.keymap
local g = vim.g

cmd.syntax('on')
cmd.syntax('enable')
opt.compatible = false

-- Enable true colour support
if fn.has('termguicolors') then
  opt.termguicolors = true
end

-- Search down into subfolders
opt.path = vim.o.path .. '**'
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.lazyredraw = true
opt.showmatch = true -- Highlight matching parentheses, etc
opt.incsearch = true
opt.hlsearch = true

-- On pressing tab, insert spaces
opt.expandtab = true
-- Show existing tab with 2 spaces width
opt.tabstop = 2
opt.softtabstop = 2
-- When indenting with '>', use 2 spaces width
opt.shiftwidth = 2
opt.foldenable = true
-- opt.foldlevelstart = 10 -- set in plugin.ufo
-- opt.foldmethod = 'indent' -- fold based on indent level
opt.history = 2000
-- Increment numbers in decimal and hexadecimal formats
opt.nrformats = 'bin,hex' -- 'octal'
-- Persist undos between sessions
opt.undofile = true
-- Split right and below
opt.splitright = true
opt.splitbelow = true
-- Global statusline
-- opt.laststatus = 3 -- managed by lualine
-- Hide command line unless typing a command or printing a message
opt.cmdheight = 0

-- Keep cursor in the middle of the pane while scrolling
-- opt.scrolloff = 10000

opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

g.markdown_syntax_conceal = 0

-- See https://github.com/hrsh7th/nvim-compe/issues/286#issuecomment-805140394
g.omni_sql_default_compl_type = 'syntax'

-- Set default shell
opt.shell = 'nu'

local function prefix_diagnostic(prefix, diagnostic)
  return string.format(prefix .. ' %s', diagnostic.message)
end

local sign = function(opts)
  fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = '',
  })
end
sign { name = 'DiagnosticSignError', text = '󰅚' }
sign { name = 'DiagnosticSignWarn', text = '⚠' }
sign { name = 'DiagnosticSignInfo', text = 'ⓘ' }
sign { name = 'DiagnosticSignHint', text = '󰌶' }

vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    format = function(diagnostic)
      local severity = diagnostic.severity
      if severity == vim.diagnostic.severity.ERROR then
        return prefix_diagnostic('󰅚', diagnostic)
      end
      if severity == vim.diagnostic.severity.WARN then
        return prefix_diagnostic('⚠', diagnostic)
      end
      if severity == vim.diagnostic.severity.INFO then
        return prefix_diagnostic('ⓘ', diagnostic)
      end
      if severity == vim.diagnostic.severity.HINT then
        return prefix_diagnostic('󰌶', diagnostic)
      end
      return prefix_diagnostic('■', diagnostic)
    end,
  },
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('DisableNewLineAutoCommentString', {}),
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

g.editorconfig = true

vim.opt.colorcolumn = '100'

-- Plugin settings
local keymap_opts = { noremap = true, silent = true }
local telescope = require('telescope')
local lsp = require('mrcjk.lsp')

g.haskell_tools = {
  tools = {
    repl = {
      handler = 'toggleterm',
      auto_focus = false,
    },
    codeLens = {
      autoRefresh = false,
    },
    definition = {
      hoogle_signature_fallback = true,
    },
  },
  hls = {
    on_attach = function(client, bufnr, ht)
      lsp.on_attach(client, bufnr)
      lsp.on_dap_attach(bufnr)
      local opts = vim.tbl_extend('keep', keymap_opts, { buffer = bufnr })
      keymap.set('n', 'gh', ht.hoogle.hoogle_signature, opts)
      keymap.set('n', '<space>tg', telescope.extensions.ht.package_grep, opts)
      keymap.set('n', '<space>th', telescope.extensions.ht.package_hsgrep, opts)
      keymap.set('n', '<space>tf', telescope.extensions.ht.package_files, opts)
      keymap.set('n', 'gp', ht.project.open_package_yaml, opts)
      keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
    end,
    capabilities = lsp.capabilities,
    default_settings = {
      haskell = {
        formattingProvider = 'stylish-haskell',
        maxCompletions = 10,
      },
    },
  },
}

-- nvim-code-action-menu
g.code_action_menu_show_action_kind = false