local cmd = vim.cmd
local set = vim.opt
local g = vim.g

local theme = 'everforest';

g.everforest_background = 'soft'

cmd('colorscheme ' .. theme);

require('lualine').setup{
	options = { theme = theme },
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'FugitiveHead'},
		lualine_c = {{ 'diagnostics', sources = { 'nvim_lsp' } }},
	},
	extensions = { 'quickfix', 'nvim-tree', 'fugitive' }
}

g.nvim_tree_ignore = {'.git', 'node_modules', '.cache', 'data'}
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 1
g.nvim_tree_quit_on_open = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_tab_open = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_lsp_diagnostics = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_respect_buf_cwd = 1
g.nvim_tree_update_cwd = 1
