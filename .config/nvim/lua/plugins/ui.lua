return {
	{
		'catppuccin/nvim',
		priority = 1000,
		name = 'catppuccin',
		opts = {
			color_overrides = {
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
		opts = {
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
		dependencies = {
			'nvim-telescope/telescope-fzf-native.nvim',
		},
	},
}
