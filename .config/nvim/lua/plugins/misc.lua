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
		version = 'v3.*.*',
		enabled = true,
		lazy = false, -- NOTE: NO NEED to Lazy load
		-- Optional
		keys = {
			-- Global Minimap Controls
			{ '<leader>nm', '<cmd>Neominimap toggle<cr>', desc = 'Toggle global minimap' },
			{ '<leader>no', '<cmd>Neominimap on<cr>', desc = 'Enable global minimap' },
			{ '<leader>nc', '<cmd>Neominimap off<cr>', desc = 'Disable global minimap' },
			{ '<leader>nr', '<cmd>Neominimap refresh<cr>', desc = 'Refresh global minimap' },

			-- Window-Specific Minimap Controls
			{ '<leader>nwt', '<cmd>Neominimap winToggle<cr>', desc = 'Toggle minimap for current window' },
			{ '<leader>nwr', '<cmd>Neominimap winRefresh<cr>', desc = 'Refresh minimap for current window' },
			{ '<leader>nwo', '<cmd>Neominimap winOn<cr>', desc = 'Enable minimap for current window' },
			{ '<leader>nwc', '<cmd>Neominimap winOff<cr>', desc = 'Disable minimap for current window' },

			-- Tab-Specific Minimap Controls
			{ '<leader>ntt', '<cmd>Neominimap tabToggle<cr>', desc = 'Toggle minimap for current tab' },
			{ '<leader>ntr', '<cmd>Neominimap tabRefresh<cr>', desc = 'Refresh minimap for current tab' },
			{ '<leader>nto', '<cmd>Neominimap tabOn<cr>', desc = 'Enable minimap for current tab' },
			{ '<leader>ntc', '<cmd>Neominimap tabOff<cr>', desc = 'Disable minimap for current tab' },

			-- Buffer-Specific Minimap Controls
			{ '<leader>nbt', '<cmd>Neominimap bufToggle<cr>', desc = 'Toggle minimap for current buffer' },
			{ '<leader>nbr', '<cmd>Neominimap bufRefresh<cr>', desc = 'Refresh minimap for current buffer' },
			{ '<leader>nbo', '<cmd>Neominimap bufOn<cr>', desc = 'Enable minimap for current buffer' },
			{ '<leader>nbc', '<cmd>Neominimap bufOff<cr>', desc = 'Disable minimap for current buffer' },

			---Focus Controls
			{ '<leader>nf', '<cmd>Neominimap focus<cr>', desc = 'Focus on minimap' },
			{ '<leader>nu', '<cmd>Neominimap unfocus<cr>', desc = 'Unfocus minimap' },
			{ '<leader>ns', '<cmd>Neominimap toggleFocus<cr>', desc = 'Switch focus on minimap' },
		},
		init = function()
			-- The following options are recommended when layout == "float"
			vim.opt.wrap = false
			vim.opt.sidescrolloff = 36 -- Set a large value

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
	{
		'3rd/image.nvim',
		enabled = not vim.g.neovide,
		opts = {},
	},
	-- { 'echasnovski/mini.operators', config = true },
}
