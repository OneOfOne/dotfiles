return {
	{ 'folke/lazy.nvim', version = false },
	{ 'LazyVim/LazyVim', version = false },
	{ 'almo7aya/openingh.nvim', config = true },
	---@module "neominimap.config.meta"
	{
		'Isrothy/neominimap.nvim',
		-- enabled = false,
		lazy = false, -- NOTE: NO NEED to Lazy load
		-- Optional
		init = function()
			local group = vim.api.nvim_create_augroup('minimap', { clear = true })

			vim.api.nvim_create_autocmd('InsertEnter', {
				group = group,
				pattern = '*',
				callback = function()
					require('neominimap').bufOff({}, {})
				end,
			})
			vim.api.nvim_create_autocmd('InsertLeave', {
				group = group,
				pattern = '*',
				callback = function()
					require('neominimap').bufOn({}, {})
				end,
			})

			---@type Neominimap.UserConfig
			vim.g.neominimap = {
				auto_enable = true,
				float = {
					window_border = 'none',
				},
				click = {
					enabled = true,
					auto_switch_focus = true,
				},
				mark = {
					enabled = true,
					show_builtins = true,
				},
				search = {
					enabled = true, ---@type boolean
					mode = 'icon', ---@type Neominimap.Handler.Annotation.Mode
					priority = 20, ---@type integer
					icon = '󰱽 ', ---@type string
				},
				delay = 250,
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
