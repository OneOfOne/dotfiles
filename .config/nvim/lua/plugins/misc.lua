return {
	{ 'folke/lazy.nvim', version = false },
	{ 'LazyVim/LazyVim', version = false },
	{ 'almo7aya/openingh.nvim', config = true },
	{
		'echasnovski/mini.map',
		config = function()
			local map = require('mini.map')
			map.setup({
				integrations = {
					map.gen_integration.diagnostic(),
					map.gen_integration.builtin_search(),
					map.gen_integration.diff(),
					map.gen_integration.gitsigns(),
				},
			})
			map.open()
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
	{
		'3rd/image.nvim',
		enabled = not vim.g.neovide,
		opts = {},
	},
	-- { 'echasnovski/mini.operators', config = true },
}
