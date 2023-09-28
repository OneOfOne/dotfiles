return {
	{ 'almo7aya/openingh.nvim', config = true },
	{ 'dstein64/nvim-scrollview', config = true },
	{ 'NvChad/nvim-colorizer.lua', config = true },
	{
		'spm.nvim',
		dir = '~/code/nvim/spm.nvim',
		config = true,
		event = 'VeryLazy',
		--enabled = false,
	},
	{
		'folke/trouble.nvim',
		opts = {
			auto_open = false,
			auto_close = true,
			use_diagnostic_signs = true,
		},
	},
	{
		'folke/flash.nvim',
		opts = {
			modes = {
				search = {
					enabled = false,
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
		'gbprod/yanky.nvim',
		dependencies = { { 'kkharji/sqlite.lua', enabled = false } },
		opts = {
			highlight = { timer = 250 },
			ring = { storage = 'shada' },
		},
	},
}
