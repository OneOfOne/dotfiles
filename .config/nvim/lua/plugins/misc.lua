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
		'folke/flash.nvim',
		event = 'VeryLazy',
		---@type Flash.Config
		opts = {
			multi_window = false,
			incremental = true,
			jump = {
				autojump = false,
			},
			label = {
				style = 'inline',
				reuse = 'all',
				rainbow = {
					enabled = false,
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
		'm4xshen/hardtime.nvim',
		enabled = false,
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
	{
		'SmiteshP/nvim-navic',
		lazy = true,
		init = function()
			vim.g.navic_silence = true
			LazyVim.lsp.on_attach(function(client, buffer)
				if client.supports_method('textDocument/documentSymbol') then
					require('nvim-navic').attach(client, buffer)
				end
			end)
		end,
		opts = function()
			vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
			return {
				separator = ' ❯ ',
				highlight = true,
				depth_limit = 10,
				icons = require('lazyvim.config').icons.kinds,
				lazy_update_context = true,
			}
		end,
	},
}
