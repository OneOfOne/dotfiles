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
				floats = 'transparent',
			},
			lualine_bold = true,

			on_highlights = function(hl)
				hl.Pmenu = 'transparent'
			end,
		},
	},
	{
		'timmypidashev/darkbox.nvim',
		lazy = false,
		name = 'darkbox',
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
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = '', -- can be "retro", "dim" or empty string for classic
			overrides = {
				Pmenu = { bg = 'none' },
				BufferLineSeparator = { bg = '#3d3836', fg = '#3d3836' },
				String = { link = 'DarkboxAqua' },
				StatusLine = { link = 'lualine_c_normal' },
			},
			dim_inactive = false,
			transparent_mode = false,
		},
	},
	{
		'LazyVim/LazyVim',
		opts = {
			-- colorscheme = 'solarized-osaka',
			colorscheme = 'darkbox',
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
		'nvim-lualine/lualine.nvim',
		-- enabled = false,
		opts = {
			options = {
				theme = 'auto',
				disabled_filetypes = {
					winbar = { 'snacks_terminal' },
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
			-- 			'filename',
			-- 			file_status = true,
			-- 			newfile_status = true,
			-- 			path = 1,
			-- 			symbols = {
			-- 				modified = '[+]',
			-- 				readonly = '[-]',
			-- 				unnamed = '[No Name]',
			-- 				newfile = '[New]',
			-- 			},
			-- 		},
			-- 	},
			-- 	lualine_b = {},
			-- 	lualine_c = {
			-- 		{
			-- 			'filetype',
			-- 			colored = true,
			-- 			icon_only = true,
			-- 			icon = { align = 'left' },
			-- 		},
			-- 	},
			-- 	lualine_x = {},
			-- 	lualine_y = {},
			-- 	lualine_z = {
			-- 		{
			-- 			'buffers',
			-- 			show_modified_status = true,
			-- 			use_mode_colors = false,
			-- 			symbols = {
			-- 				modified = ' ●',
			-- 				alternate_file = '',
			-- 				directory = '',
			-- 			},
			-- 			buffers_color = {
			-- 				-- Same values as the general color option can be used here.
			-- 				active = 'lualine_a_normal', -- Color for active buffer.
			-- 				inactive = 'lualine_a_inactive', -- Color for inactive buffer.
			-- 			},
			-- 		},
			-- 	},
			-- },
			-- inactive_winbar = {
			-- 	lualine_a = {
			-- 		{
			-- 			'filename',
			-- 			file_status = true,
			-- 			newfile_status = true,
			-- 			path = 1,
			-- 			symbols = {
			-- 				modified = '[+]',
			-- 				readonly = '[-]',
			-- 				unnamed = '[No Name]',
			-- 				newfile = '[New]',
			-- 			},
			-- 		},
			-- 	},
			-- 	lualine_b = {
			-- 		{
			-- 			'filetype',
			-- 			colored = true,
			-- 			icon_only = true,
			-- 			icon = { align = 'left' },
			-- 		},
			-- 	},
			-- 	lualine_c = {},
			-- 	lualine_x = {},
			-- 	lualine_y = {
			-- 		{
			-- 			'buffers',
			-- 			show_modified_status = true,
			-- 			use_mode_colors = true,
			-- 			symbols = {
			-- 				modified = ' ●',
			-- 				alternate_file = '',
			-- 				directory = '',
			-- 			},
			-- 		},
			-- 	},
			-- 	lualine_z = {},
			-- },
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
				{ filter = { find = 'Searching in files' } },
				{ filter = { find = 'textDocument/codeLens is not supported' } },
			},
		},
	},
	{
		'sphamba/smear-cursor.nvim',
		opts = {
			stiffness = 0.5,
			trailing_stiffness = 0.49,
			never_draw_over_target = false,
		},
	},
}
