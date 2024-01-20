local function setup(mod)
  require(mod).setup()
end

setup('wildfire')
setup('Comment')
setup('neoconf')
setup('tmux')
setup('nvim-highlight-colors')

if not vim.g.nvim_surround_setup then
  setup('nvim-surround')
  vim.g.nvim_surround_setup = true
end
