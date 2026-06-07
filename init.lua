vim.g.mapleader = ' '
vim.o.clipboard = 'unnamedplus'

if vim.g.vscode then
    vim.keymap.set('n', '<leader>w', [[<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>]])
    vim.keymap.set('n', '<leader>q', [[<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>]])
    vim.keymap.set('n', '<leader>Q', [[<Cmd>call VSCodeNotify('workbench.action.closeWindow')<CR>]])
    
    vim.keymap.set('n', '<leader>`', [[<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>]])
    
    vim.keymap.set('n', '<leader>f', [[<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>]])
    vim.keymap.set('n', '<leader>b', [[<Cmd>call VSCodeNotify('workbench.action.showAllEditors')<CR>]])
    vim.keymap.set('n', '<leader>e', [[<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>]])
    
    vim.keymap.set('n', '<leader>gs', [[<Cmd>call VSCodeNotify('workbench.view.scm')<CR>]])
    vim.keymap.set('n', '<leader>gd', [[<Cmd>call VSCodeNotify('git.openChangeToTarget')<CR>]])
    vim.keymap.set('n', '<leader>gb', [[<Cmd>call VSCodeNotify('git.timeline.focus')<CR>]])
    vim.keymap.set('n', '<leader>gp', [[<Cmd>call VSCodeNotify('git.push')<CR>]])
    vim.keymap.set('n', '<leader>gP', [[<Cmd>call VSCodeNotify('git.pull')<CR>]])
    
    vim.keymap.set('n', '<leader>/', [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]])
    vim.keymap.set('v', '<leader>/', [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]])

else
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.wrap = false
    vim.o.swapfile = false
	vim.o.tabstop = 4
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true
    
    vim.keymap.set('n', '<leader>w', ':write<CR>')
    vim.keymap.set('n', '<leader>q', ':quit<CR>')
    vim.keymap.set('n', '<leader>Q', ':q!<CR>')
    vim.keymap.set('n', '<leader>`', ':belowright split | terminal<CR>')
    
    vim.pack.add({
        {src = 'https://github.com/Shatur/neovim-ayu'},
        {src = 'https://github.com/echasnovski/mini.pick'},
        {src = 'https://github.com/stevearc/oil.nvim'},
        {src = 'https://github.com/numToStr/Comment.nvim'},
        {src = 'https://github.com/tpope/vim-fugitive'},
        {src = 'https://github.com/lewis6991/gitsigns.nvim'},
        {src = 'https://github.com/nvim-lualine/lualine.nvim'},
        {src = 'https://github.com/xiyaowong/transparent.nvim'},
        {src = 'https://github.com/chomosuke/typst-preview.nvim'},
    })
    
    require('typst-preview').setup {
        debug = false,
        open_cmd = nil,
        port = 0,
        invert_colors = 'never',
        follow_cursor = true,
        dependencies_bin = { ['tinymist'] = nil, ['websocat'] = nil },
        extra_args = nil,
        get_root = function(p) return os.getenv('TYPST_ROOT') or vim.fn.fnamemodify(p, ':p:h') end,
        get_main_file = function(p) return p end,
    }
    
    require('transparent').setup({
        groups = {
            'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
            'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
            'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
            'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
            'EndOfBuffer',
        },
    })

    require('mini.pick').setup()
    require('oil').setup()
    require('gitsigns').setup({ signcolumn = true, numhl = false, linehl = false })
    require('Comment').setup()

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

    vim.keymap.set('n', '<leader>/', function() require('Comment.api').toggle.linewise.current() end)
    vim.keymap.set('v', '<leader>/', function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        require('Comment.api').toggle.linewise(vim.fn.visualmode())
    end)

    
	local function git_rn()
	    if vim.fn.isdirectory('.git') == 0 then return '' end
	    local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD 2>/dev/null'):gsub('\n', '')
	    local has_changes = vim.fn.system('git status --porcelain 2>/dev/null') ~= ''
	    
	    return has_changes and (' ' .. branch .. '*') or (' ' .. branch)
	end

    require('lualine').setup({
        options = { section_separators = '', component_separators = '' },
        sections = {
            lualine_a = { 'mode' }, lualine_b = { git_rn, 'diff', 'diagnostics' }, lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'filetype' }, lualine_y = { 'progress' }, lualine_z = { 'location' },
        },
    })

    vim.cmd('colorscheme ayu') 
end
