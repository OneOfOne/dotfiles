return {
	{
		'craftzdog/solarized-osaka.nvim',
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = { bold = true },
				variables = { italic = true },

				sidebars = 'transparent',
				floats = 'dark',
			},
			dim_inactive = false,
			lualine_bold = true,

			---@diagnostic disable-next-line: unused-local
			on_highlights = function(hl, colors)
				hl.Pmenu = 'transparent'
				-- hl.BufferLineSeparatorSelected = { bg = '#002630', fg = '#001217' }
				-- hl.BufferLineSeparatorVisible = { bg = '#002630' }
				hl.BufferLineBufferSelected = { fg = '#ffffff' }
			end,
		},
	},
	{
		'timmypidashev/darkbox.nvim',
		lazy = false,
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
				variables = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = '', -- can be "retro", "dim" or empty string for classic
			palette_overrides = {},
			overrides = {
				Pmenu = { bg = 'none' },
				SnacksPickerPathHidden = { link = 'SnacksPickerFile' },
				BufferLineBufferSelected = { fg = '#ffffff', bg = 'red' },
			},
			dim_inactive = false,
			transparent_mode = true,
		},
	},
	{
		'LazyVim/LazyVim',
		opts = {
			colorscheme = 'solarized-osaka',
			-- colorscheme = 'darkbox',
		},
	},
	{
		'akinsho/bufferline.nvim',
		-- enabled = false,
		opts = {
			options = {
				always_show_bufferline = true,
				themable = true,
				show_close_icon = false,
				show_buffer_close_icons = false,
				separator_style = 'slant',
				left_mouse_command = function(bufnum)
					vim.fn.win_gotoid(vim.g.main_win or 1000) -- Assume 1000 is the main window if vim.g.main_win is nil
					vim.api.nvim_set_current_buf(bufnum)
				end,
			},
		},
	},
	{
		-- Calls `require('slimline').setup({})`
		'sschleemilch/slimline.nvim',
		enabled = false,
		opts = {
			hl = {
				modes = {
					normal = 'Type', -- highlight base of modes
					insert = 'Function',
					pending = 'Boolean',
					visual = 'Keyword',
					command = 'String',
				},
				base = 'Comment', -- highlight of everything in in between components
				primary = 'Normal', -- highlight of primary parts (e.g. filename)
				secondary = 'Comment', -- highlight of secondary parts (e.g. filepath)
			},
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		-- enabled = false,
		opts = {
			options = {
				theme = 'auto',
				disabled_filetypes = {
					winbar = { 'neo-tree', 'alpha', 'snacks_terminal' },
				},
				component_seperators = { left = '', right = '' },
				section_seperators = { left = '', right = '' },
			},
			sections = {
				lualine_y = {
					{ 'searchcount', padding = { left = 1, right = 0 }, separator = ' ' },
					{ 'selectioncount', padding = { left = 1, right = 0 }, separator = ' ' },
					{ 'location', padding = { left = 0, right = 1 } },
				},
			},
			-- winbar = {
			-- 	lualine_a = {
			-- 		{
			-- 			'buffers',
			-- 			symbols = {
			-- 				modified = ' ●',
			-- 				alternate_file = '',
			-- 				directory = '',
			-- 			},
			-- 		},
			-- 	},
			-- 	lualine_y = { 'diagnostics' },
			-- 	lualine_z = { 'tabs' },
			-- },
			-- inactive_winbar = {
			-- 	lualine_a = {
			-- 		{
			-- 			'buffers',
			-- 			symbols = {
			-- 				modified = ' ●',
			-- 				alternate_file = '',
			-- 				directory = '',
			-- 			},
			-- 		},
			-- 	},
			-- 	lualine_y = { 'diagnostics' },
			-- 	lualine_z = { 'tabs' },
			-- },
		},
	},
	{
		'folke/noice.nvim',
		-- enabled = false,
		opts = {
			presets = {
				lsp_doc_border = true,
			},
			lsp = {
				hover = { enabled = true },
				signature = { enabled = true },
			},
			smart_move = { enabled = true },
			routes = {
				{ filter = { event = 'msg_show', find = 'written' } },
				{ filter = { event = 'msg_show', find = 'yanked' } },
				{ filter = { event = 'msg_show', find = '%d+L, %d+B' } },
				{ filter = { event = 'msg_show', find = '; after #%d+' } },
				{ filter = { event = 'msg_show', find = '; before #%d+' } },
				{ filter = { event = 'msg_show', find = '%d fewer lines' } },
				{ filter = { event = 'msg_show', find = '%d more lines' } },
				{ filter = { event = 'msg_show', find = '<ed' } },
				{ filter = { event = 'msg_show', find = '>ed' } },
				{ filter = { find = 'a nil value' } },
				{
					filter = {
						event = 'notify',
						any = {
							{ find = 'textDocument/codeLens is not supported' },
							{ find = 'Searching in Files' },
						},
					},
				},
			},
		},
	},
}
