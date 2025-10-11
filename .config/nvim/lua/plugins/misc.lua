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
					require('neominimap.api').buf.disable()
				end,
			})
			vim.api.nvim_create_autocmd({ 'LspAttach', 'InsertLeave' }, {
				group = group,
				pattern = '*',
				callback = function()
					require('neominimap.api').buf.enable()
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
				delay = 500,
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
		-- enabled = false,
		opts = {
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
		},
	},
	{
		'folke/which-key.nvim',
		opts = {
			-- preset = 'modern',
		},
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			current_line_blame = true,
		},
	},
	{
		'sindrets/diffview.nvim',
		opts = {},
	},
	{
		'gbprod/cutlass.nvim',
		opts = {
			cut_key = 'x',
			exclude = { 'xd' },
			registers = {
				select = '+',
			},
		},
	},
	-- {
	-- 	'tris203/precognition.nvim',
	-- 	--event = "VeryLazy",
	-- 	opts = {},
	-- },
}
