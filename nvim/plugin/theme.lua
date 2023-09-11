vim.g.material_style = 'darker'
vim.g.material_terminal_italics = 1

require('material').setup {
  contrast = {
    terminal = true,
    floating_windows = false,
    cursor_line = true,
    non_current_windows = true,
  },
  styles = {
    comments = { italic = true },
  },
  plugins = {
    'dap',
    'dashboard',
    'gitsigns',
    'hop',
    'indent-blankline',
    'lspsaga',
    'mini',
    'neogit',
    'nvim-cmp',
    'nvim-navic',
    'nvim-tree',
    'sneak',
    'telescope',
    'trouble',
    'which-key',
  },
  disable = {
    colored_cursor = true,
  },
  high_visibility = {
    lighter = true,
    darker = true,
  },
  async_loading = true,
  custom_highlights = {
    LspCodeLens = { link = 'DiagnosticHint', italic = true },
    TermCursor = { link = 'Cursor' },
    TermCursorNC = { bg = '#FF5370', fg = 'white', ctermbg = 1, ctermfg = 15 },
    FidgetTitle = { link = 'DiagnosticHint' },
    IlluminatedWordRead = { link = 'TSDefinitionUsage' },
    IlluminatedWordWrite = { link = 'TSDefinitionUsage' },
    IlluminatedWordText = { link = 'TSDefinitionUsage' },
    NeotestPassed = { fg = '#ABCF76' },
    NeotestFailed = { link = 'DiagnosticError' },
    NeotestRunning = { link = 'DiagnosticWarn' },
    NeotestTarget = { link = 'DiagnosticError' },
    NeotestAdapterName = { link = 'DiagnosticHint' },
    NeotestDir = { link = 'DiagnosticHint' },
    NeotestFile = { link = 'DiagnosticHint' },
    NeotestSkipped = { link = 'DiagnosticHint' },
    DapUINormal = { link = 'Normal' },
    DapUIScope = { fg = '#E6B455' },
    DapUIType = { fg = '#B480D6' },
    DapUIValue = { link = 'Normal' },
    DapUIModifiedValue = { fg = '#E6B455', bold = true },
    DapUIDecoration = { fg = '#E6B455' },
    DapUIThread = { fg = '#ABCF76' },
    DapUIStoppedThread = { fg = '#71C6E7' },
    DapUIFrameName = { link = 'Normal' },
    DapUISource = { fg = '#B480D6' },
    DapUILineNumber = { fg = '#71C6E7' },
    DapUIEndofBuffer = { link = 'EndofBuffer' },
    EyelinerPrimary = {
      link = 'DiagnosticWarn',
      bold = true,
      underline = true,
      ctermfg = 155,
      cterm = { underline = true },
    },
    EyelinerSecondary = { link = 'DiagnosticHint', underline = true, ctermfg = 155, cterm = { underline = true } },
  },
  custom_colors = function(colors)
    colors.editor.fg = '#FFFFFF'
    colors.editor.fg_dark = colors.main.white
    colors.editor.accent = colors.main.darkpurple
  end,
}
vim.cmd.colorscheme('material')