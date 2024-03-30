return {
	{ 'folke/lazy.nvim', version = false },
	{ 'LazyVim/LazyVim', version = false },
	{ 'almo7aya/openingh.nvim', config = true },
	-- { 'dstein64/nvim-scrollview', config = true }, -- lags nvim big time
	{
		'spm.nvim',
		dir = '~/code/nvim/spm.nvim',
		config = true,
		event = 'VeryLazy',
		--enabled = false,
	},
	-- {
	-- 	'folke/trouble.nvim',
	-- 	opts = {
	-- 		auto_open = false,
	-- 		auto_close = true,
	-- 		use_diagnostic_signs = true,
	-- 	},
	-- },
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
		'm4xshen/hardtime.nvim',
		dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
		opts = {
			disabled_keys = {
				['<Up>'] = {},
				['<Down>'] = {},
				['<Left>'] = {},
				['<Right>'] = {},
			},
			disable_mouse = false,
			restriction_mode = 'hint',
		},
	},
}
