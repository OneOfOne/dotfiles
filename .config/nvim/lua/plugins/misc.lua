return {
	{ 'folke/lazy.nvim', version = false },
	{ 'LazyVim/LazyVim', version = false },
	{ 'almo7aya/openingh.nvim', config = true },
	-- { 'dstein64/nvim-scrollview', config = true }, -- lags nvim big time
	{ 'NvChad/nvim-colorizer.lua', config = true, enabled = false },
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
	{
		'bloznelis/before.nvim',
		opts = {
			history_size = 42,
			history_wrap_enabled = true,
			telescope_for_preview = true,
		},
		config = function(_, opts)
			local before = require('before')
			before.setup(opts)
			vim.keymap.set('n', '<leader>ol', before.jump_to_last_edit, { desc = 'jump to last edit' })
			vim.keymap.set('n', '<leader>on', before.jump_to_next_edit, { desc = 'jump to next edit' })
			vim.keymap.set('n', '<leader>oe', before.show_edits, { desc = 'edit list' })
		end,
	},
}
