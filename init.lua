vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
-- vim.o.tabstop = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"

vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>Q', ':q!<CR>')

vim.keymap.set('n', '<leader>`', ':belowright split | terminal<CR>')

vim.pack.add({
	{src = "https://github.com/Shatur/neovim-ayu"},
	{src = "https://github.com/echasnovski/mini.pick"},
	{src = "https://github.com/stevearc/oil.nvim"},
	{src = "https://github.com/numToStr/Comment.nvim"},
	{src = "https://github.com/tpope/vim-fugitive"},
	{src = "https://github.com/lewis6991/gitsigns.nvim"},
	{src = "https://github.com/nvim-lualine/lualine.nvim"},
	{src = "https://github.com/xiyaowong/transparent.nvim"},
})

require 'transparent'.setup({
  groups = {
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  on_clear = function() end,
})

require 'mini.pick'.setup()
require 'oil'.setup()
require 'gitsigns'.setup({
  signcolumn = true,
  numhl      = false,
  linehl     = false,
})
require 'Comment'.setup()
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>b', ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>e', ':vert rightbelow Oil<CR>')

vim.keymap.set('n', '<leader>gs', ':vert rightbelow Git<CR>')
vim.keymap.set('n', '<leader>ga', ':vert rightbelow Git add %<CR>')
vim.keymap.set('n', '<leader>gu', ':vert rightbelow Git restore --staged %<CR>')
vim.keymap.set('n', '<leader>gc', ':rightbelow Git commit<CR>')
vim.keymap.set('n', '<leader>gd', ':vert rightbelow Gdiffsplit<CR>')
vim.keymap.set('n', '<leader>gb', ':vert rightbelow Git blame<CR>')
vim.keymap.set('n', '<leader>gp', ':vert rightbelow Git push<CR>')
vim.keymap.set('n', '<leader>gP', ':vert rightbelow Git pull<CR>')

vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end)

vim.keymap.set("v", "<leader>/", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end)

local function git_rn()
  if vim.fn.isdirectory(".git") == 0 then
    return ""
  end

  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")

  local git_status = vim.fn.system("git status --porcelain 2>/dev/null")
  if git_status ~= "" then
    return " " .. branch .. "*"
  end
  return " " .. branch
end

require("lualine").setup({
  options = {
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { git_rn, "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

vim.cmd("colorscheme ayu") 
