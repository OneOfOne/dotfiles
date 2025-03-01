return {
	{ 'folke/lazy.nvim', version = false },
	{ 'LazyVim/LazyVim', version = false },
	---@module "neominimap.config.meta"
	{
		'Isrothy/neominimap.nvim',
		-- enabled = false,
		event = 'LspAttach',
		lazy = true,
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
		-- dev = true,
		-- dir = '~/code/nvim/spm.nvim',
		config = true,
		lazy = false,
		version = false,
		-- enabled = false,
	},
	{
		'folke/flash.nvim',
		keys = {
			{
				'<a-s>',
				mode = { 'i' },
				function()
					require('flash').jump()
				end,
				desc = 'Flash',
			},
		},
		opts = {
			jump = {},
			modes = {
				char = {
					jump_labels = true,
					search = { wrap = true },
				},
			},
			search = {
				multi_window = false,
				incremental = true,
				mode = function(str)
					return '\\<' .. str
				end,
			},
			label = {
				style = 'inline',
				reuse = 'all',
				rainbow = {
					enabled = true,
					shade = 9,
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
			mappings = {
				delete = '<leader>d',
			},
		},
	},
	{
		'folke/which-key.nvim',
		opts = {
			preset = 'modern',
		},
	},
	-- { 'echasnovski/mini.operators', config = true },
}
