return {
	{
		'catppuccin/nvim',
		priority = 1000,
		name = 'catppuccin',
		opts = {
			highlight_overrides = {
				all = function(colors)
					return {
						CurSearch = { bg = colors.sky },
						IncSearch = { bg = colors.sky },
						CursorLineNr = { fg = colors.blue, style = { 'bold' } },
						Folded = { bg = colors.base, fg = colors.overlay0 },

						WinSeparator = { fg = colors.surface1 },
						NeoTreeWinSeparator = { fg = colors.surface1 },

						Headline = { style = { 'bold' } },
						Headline1 = { style = { 'bold' } },
						Headline2 = { style = { 'bold' } },
						Headline3 = { style = { 'bold' } },
						Headline4 = { style = { 'bold' } },
						Headline5 = { style = { 'bold' } },
						Headline6 = { style = { 'bold' } },
					}
				end,
			},
			color_overrides = {
				mocha = {
					rosewater = '#d4be9B',
					flamingo = '#d4be98',
					pink = '#AD6FF7',
					mauve = '#FF8F40',
					red = '#E66767',
					maroon = '#00BBCC',
					peach = '#FAB770',
					yellow = '#FACA64',
					green = '#70CF67',
					teal = '#4CD4BD',
					sky = '#61BDFF',
					sapphire = '#4BA8FA',
					blue = '#00BFFF',
					lavender = '#00BBCC',
					text = '#d1be91',
					subtext1 = '#d4be98',
					subtext0 = '#8E94AB',
					overlay2 = '#7D8296',
					overlay1 = '#676B80',
					overlay0 = '#666977',
					surface2 = '#3A3D4A',
					surface1 = '#454545', --''#5F515D',
					surface0 = '#404040',
					-- base = '#17212c',
					base = '#1f1c16',
					mantle = '#1f1c16',
					-- mantle = '#17212c',
					crust = '#353535',
				},
			},
		},
	},
	{
		'https://gitlab.com/bartekjaszczak/finale-nvim',
		config = function() end,
	},
	{
		'LazyVim/LazyVim',
		opts = {
			colorscheme = 'catppuccin',
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
			},
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			sections = {
				lualine_y = {
					{ 'searchcount', padding = { left = 1, right = 0 }, separator = ' ' },
					{ 'selectioncount', padding = { left = 1, right = 0 }, separator = ' ' },
					{ 'location', padding = { left = 0, right = 1 } },
				},
			},
			-- winbar = {
			-- 	lualine_a = { 'buffers' },
			-- 	lualine_b = {},
			-- 	lualine_c = {},
			-- 	lualine_x = {},
			-- 	lualine_y = {},
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
				{
					filter = {
						event = 'notify',
						any = {
							{ find = 'textDocument/codeLens is not supported' },
							{ find = 'Searching in Files' },
						},
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = 'msg_show',
						any = {
							{ find = '%d+L, %d+B' },
							{ find = '; after #%d+' },
							{ find = '; before #%d+' },
						},
					},
					view = 'mini',
				},
			},
		},
	},
	{
		'folke/snacks.nvim',
		opts = {
			statuscolumn = {
				enabled = true,
				folds = {
					open = true, -- show open fold icons
					git_hl = true, -- use Git Signs hl for fold icons
				},
			},
		},
	},
}
