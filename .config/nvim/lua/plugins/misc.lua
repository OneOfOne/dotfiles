return {
	{ 'folke/lazy.nvim', version = false },
	{ 'LazyVim/LazyVim', version = false },
	{ 'almo7aya/openingh.nvim', config = true },

	-- { 'echasnovski/mini.map', version = false, config = true },
	{ 'itchyny/vim-qfedit', config = function() end },
	{ 'dstein64/nvim-scrollview', config = true },
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
		event = 'VeryLazy',
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
	{
		'viocost/viedit',
		config = function()
			require('viedit').setup()
		end,
	},
	{
		'folke/snacks.nvim',
		opts = {
			input = { enabled = true },
			-- animate = { enabled = true },
			indent = {
				enabled = true,
				chunk = {
					enabled = true,
				},
			},

			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
			-- scope = { siblings = true },
		},
	},
}
