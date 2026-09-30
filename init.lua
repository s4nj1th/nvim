vim.g.mapleader = ' '
vim.o.clipboard = 'unnamedplus'

local map = vim.keymap.set

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = 'yes'

vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.showbreak = '↪ '

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.smoothscroll = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

vim.o.updatetime = 250
vim.o.timeoutlen = 400
vim.o.termguicolors = true
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.mouse = 'a'
vim.o.completeopt = 'menuone,noselect'

vim.keymap.set('n', '<leader>w', '<Cmd>write<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', '<Cmd>quit<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>Q', '<Cmd>q!<CR>', { desc = 'Force quit' })

vim.pack.add({
    { src = 'https://github.com/Shatur/neovim-ayu' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/numToStr/Comment.nvim' },
    { src = 'https://github.com/tpope/vim-fugitive' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/xiyaowong/transparent.nvim' },
})

require('mini.pick').setup()
require('oil').setup()
require('Comment').setup()

require('gitsigns').setup({
    signcolumn = true,
    numhl = false,
    linehl = false,
})

map('n', '<leader>f', '<Cmd>Pick files<CR>', { desc = 'Find files' })
map('n', '<leader>b', '<Cmd>Pick buffers<CR>', { desc = 'Find buffers' })
map('n', '<leader>e', '<Cmd>vert rightbelow Oil<CR>', { desc = 'File explorer' })

map('n', '<leader>gs', '<Cmd>vert rightbelow Git<CR>', { desc = 'Git status' })
map('n', '<leader>ga', '<Cmd>vert rightbelow Git add %<CR>', { desc = 'Stage file' })
map('n', '<leader>gu', '<Cmd>vert rightbelow Git restore --staged %<CR>', { desc = 'Unstage file' })
map('n', '<leader>gc', '<Cmd>rightbelow Git commit<CR>', { desc = 'Git commit' })
map('n', '<leader>gd', '<Cmd>vert rightbelow Gdiffsplit<CR>', { desc = 'Git diff' })
map('n', '<leader>gb', '<Cmd>vert rightbelow Git blame<CR>', { desc = 'Git blame' })
map('n', '<leader>gp', '<Cmd>vert rightbelow Git push<CR>', { desc = 'Git push' })
map('n', '<leader>gP', '<Cmd>vert rightbelow Git pull<CR>', { desc = 'Git pull' })

map('n', '<leader>/', 'gcc', { remap = true, desc = 'Toggle comment' })
map('x', '<leader>/', 'gc', { remap = true, desc = 'Toggle comment' })

map('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
map('n', 'n', 'nzzzv', { desc = 'Next search result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', '<leader>h', '<C-w>h', { desc = 'Move to left split' })
map('n', '<leader>j', '<C-w>j', { desc = 'Move to lower split' })
map('n', '<leader>k', '<C-w>k', { desc = 'Move to upper split' })
map('n', '<leader>l', '<C-w>l', { desc = 'Move to right split' })

map('n', '<leader>`', function()
    vim.cmd('belowright split | terminal')
    vim.cmd('startinsert')
end, { desc = 'Open terminal' })

map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

map('t', '<C-h>', [[<C-\><C-n><C-w>h]])
map('t', '<C-j>', [[<C-\><C-n><C-w>j]])
map('t', '<C-k>', [[<C-\><C-n><C-w>k]])
map('t', '<C-l>', [[<C-\><C-n><C-w>l]])

require('lualine').setup({
    options = {
        section_separators = '',
        component_separators = '',
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})

require('transparent').setup({
    extra_groups = {
        'NormalFloat',
        'NvimTreeNormal',
        'SignColumn',
        'StatusLine',
        'StatusLineNC',
    },
    exclude_groups = {},
})

require('transparent').clear_prefix()
require('transparent').toggle(true)

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        vim.api.nvim_set_hl(0, 'LineNr', {
            fg = '#555555',
            bg = 'NONE',
        })

        vim.api.nvim_set_hl(0, 'CursorLineNr', {
            fg = '#cccccc',
            bg = 'NONE',
        })
    end,
})

vim.cmd.colorscheme('ayu')
