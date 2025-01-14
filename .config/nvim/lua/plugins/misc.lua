return {
	{ 'folke/lazy.nvim', version = false },
	{ 'LazyVim/LazyVim', version = false },
	{ 'almo7aya/openingh.nvim', config = true },
	{
		'echasnovski/mini.map',
		enabled = false,
		config = function()
			local map = require('mini.map')
			map.setup({
				integrations = {
					map.gen_integration.diagnostic(),
					map.gen_integration.builtin_search(),
					map.gen_integration.diff(),
					map.gen_integration.gitsigns(),
				},
				window = {
					focusable = true,
					winblend = 100,
				},
			})
			map.open()
		end,
	}, ---@module "neominimap.config.meta"
	{
		'Isrothy/neominimap.nvim',
		enabled = true,
		lazy = false, -- NOTE: NO NEED to Lazy load
		-- Optional
		init = function()
			--- Put your configuration here
			---@type Neominimap.UserConfig
			vim.g.neominimap = {
				auto_enable = true,
				float = {
					window_border = 'none',
				},
				click = {
					enabled = true,
				},
				mark = {
					enabled = true,
					show_builtins = true,
				},
			}
		end,
	},
	{
		'OneOfOne/spm.nvim',
		dev = true,
		dir = '~/code/nvim/spm.nvim',
		config = true,
		lazy = false,
		-- enabled = false,
	},
	{
		'folke/flash.nvim',
		opts = {
			multi_window = false,
			incremental = true,
			jump = {
				autojump = false,
			},
			search = {
				mode = function(str)
					return '\\<' .. str
				end,
			},
			label = {
				style = 'inline',
				reuse = 'all',
				rainbow = {
					enabled = true,
					-- number between 1 and 9
					shade = 5,
				},
			},
		},
	},
	{
		'chentoast/marks.nvim',
		event = 'BufReadPre',
		opts = {
			default_mappings = true,
			force_write_shada = false,
			refresh_interval = 250,
		},
	},
	-- { 'echasnovski/mini.operators', config = true },
}
