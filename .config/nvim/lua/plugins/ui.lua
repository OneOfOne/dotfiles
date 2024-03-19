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
						DashboardFooter = { fg = colors.overlay0 },
						TreesitterContextBottom = { style = {} },
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
					rosewater = '#F5B8AB',
					flamingo = '#F29D9D',
					pink = '#AD6FF7',
					mauve = '#FF8F40',
					red = '#E66767',
					maroon = '#EB788B',
					peach = '#FAB770',
					yellow = '#FACA64',
					green = '#70CF67',
					teal = '#4CD4BD',
					sky = '#61BDFF',
					sapphire = '#4BA8FA',
					blue = '#00BFFF',
					lavender = '#00BBCC',
					text = '#C1C9E6',
					subtext1 = '#A3AAC2',
					subtext0 = '#8E94AB',
					overlay2 = '#7D8296',
					overlay1 = '#676B80',
					overlay0 = '#464957',
					surface2 = '#3A3D4A',
					surface1 = '#464957', --''#5F515D',
					surface0 = '#1D1E29',
					base = '#232728',
					mantle = '#232728',
					crust = '#333738',

					-- base = '#0b0b12',
					-- mantle = '#11111a',
					-- crust = '#191926',
				},
			},
			xcolor_overrides = {
				mocha = { -- custom
					rosewater = '#A24944',
					flamingo = '#EA6962',
					pink = '#D3869B',
					mauve = '#D3869B',
					red = '#EA6962',
					maroon = '#875664',
					peach = '#BD6F3E',
					yellow = '#D8A657',
					green = '#A9B665',
					teal = '#89B482',
					sky = '#89B482',
					sapphire = '#89B482',
					blue = '#7DAEA3',
					lavender = '#7DAEA3',
					text = '#D4BE98',
					subtext1 = '#BDAE8B',
					subtext0 = '#A69372',
					overlay2 = '#8C7A58',
					overlay1 = '#735F3F',
					overlay0 = '#5A4525',
					surface2 = '#4B4F51',
					surface1 = '#3A3D3E',
					surface0 = '#3A3D3E',
					base = '#232728',
					mantle = '#232728',
					crust = '#333738',
				},
			},
		},
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
		},
	},
	{
		'folke/noice.nvim',
		opus = {
			presets = {
				lsp_doc_border = true,
			},
			lsp = {
				hover = { enabled = true },
				signature = { enabled = true },
			},
			smart_move = { enabled = true },
		},
	},
	{
		'Bekaboo/dropbar.nvim',
		enabled = false,
		dependencies = {
			'nvim-telescope/telescope-fzf-native.nvim',
		},
	},
}
