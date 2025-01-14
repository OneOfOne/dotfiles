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

			on_highlights = function(hl, colors)
				hl.Pmenu = 'transparent'
			end,
		},
	},
	{
		'LazyVim/LazyVim',
		opts = {
			colorscheme = 'solarized-osaka',
		},
	},
	{
		'akinsho/bufferline.nvim',
		-- enabled = false,
		opts = {
			options = {
				always_show_bufferline = true,
				themable = true,
				separator_style = 'slope',
				left_mouse_command = function(bufnum)
					vim.fn.win_gotoid(vim.g.main_win or 1000) -- assume 1000 is the main window if vim.g.main_win is nil
					vim.api.nvim_set_current_buf(bufnum)
				end,
			},
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				theme = 'solarized-osaka',
			},
			sections = {
				lualine_y = {
					{ 'searchcount', padding = { left = 1, right = 0 }, separator = ' ' },
					{ 'selectioncount', padding = { left = 1, right = 0 }, separator = ' ' },
					{ 'location', padding = { left = 0, right = 1 } },
				},
			},
			winbar = {
				-- lualine_a = { 'buffers' },
				-- 	lualine_b = {},
				-- 	lualine_c = {},
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = { 'tabs' },
			},
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
	{
		'folke/snacks.nvim',
		opts = {
			statuscolumn = {
				folds = {
					open = true, -- show open fold icons
					git_hl = true, -- use Git Signs hl for fold icons
				},
			},
			indent = {
				enabled = true,
				hl = {
					'SnacksIndent1',
					'SnacksIndent2',
					'SnacksIndent3',
					'SnacksIndent4',
					'SnacksIndent5',
					'SnacksIndent6',
					'SnacksIndent7',
					'SnacksIndent8',
				},
				chunk = {
					enabled = true,
				},
				blank = {
					char = ' ',
				},
			},
			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
		},
	},
}
