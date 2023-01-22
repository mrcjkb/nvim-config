-- Highlight terminal cursor
vim.api.nvim_set_hl(0, 'TermCursor', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'TermCursorNC', { bg = 'red', fg = 'white', ctermbg = 1, ctermfg = 15 })
vim.api.nvim_set_hl(0, 'FidgetTitle', { link = 'DiagnosticHint' })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'TSDefinitionUsage' })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'TSDefinitionUsage' })
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'TSDefinitionUsage' })