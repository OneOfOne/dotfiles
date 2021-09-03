local cmd = vim.cmd
local set = vim.opt
local g = vim.g

local theme = 'everforest';

g.everforest_background = 'soft'

cmd('colorscheme ' .. theme);

local tabline = require('tabline');
tabline.setup();

require('lualine').setup{
	options = {
		theme = theme,
		icons_enabled = true,
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = { {'FugitiveHead', icon = '' }, { 'diff' } },
		lualine_c = { {'filename', file_status = true, path = 1 } },
		--lualine_c = { tabline.tabline_buffers },
		lualine_x = { {'diff'} },
	},
	inactive_sections = {
		lualine_a = {  },
		-- lualine_b = {  },
		lualine_b = { {'branch', icon = ''} },
		lualine_c = { {'filename', file_status = true, path = 1 } },
		lualine_x = {  },
		lualine_y = {  },
		lualine_z = {  }
	},
	extensions = { 'quickfix', 'fugitive' }
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
