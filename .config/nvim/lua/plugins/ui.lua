local nopts = {
	border = {
		style = 'rounded',
	},
	win_options = {
		winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
	},
}

return {
	{
		'catppuccin/nvim',
		lazy = true,
		name = 'catppuccin',
		opts = {
			color_overrides = {
				mocha = { -- custom
					rosewater = '#ffc6be',
					flamingo = '#fb4934',
					pink = '#ff75a0',
					mauve = '#f2594b',
					red = '#f2594b',
					maroon = '#fe8019',
					peach = '#FFAD7D',
					yellow = '#e9b143',
					green = '#b0b846',
					teal = '#8bba7f',
					sky = '#7daea3',
					sapphire = '#689d6a',
					blue = '#80aa9e',
					lavender = '#e2cca9',
					text = '#e2cca9',
					subtext1 = '#e2cca9',
					subtext0 = '#e2cca9',
					overlay2 = '#8C7A58',
					overlay1 = '#735F3F',
					overlay0 = '#806234',
					surface2 = '#665c54',
					surface1 = '#3c3836',
					surface0 = '#32302f',
					base = '#282828',
					mantle = '#1d2021',
					crust = '#1b1b1b',
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
			views = {
				popup = nopts,
			},
			lsp = {
				hover = { enabled = true, opts = nopts },
				signature = { enabled = true, opts = nopts },
				documentation = {
					opts = {
						win_options = {
							concealcursor = 'n',
							conceallevel = 3,
							winhighlight = {
								Normal = 'Normal',
								FloatBorder = 'Todo',
							},
						},
					},
				},
			},
		},
	},
	{
		'simrat39/symbols-outline.nvim',
		cmd = 'SymbolsOutline',
		keys = { { '<leader>cs', '<cmd>SymbolsOutline<cr>', desc = 'Symbols Outline' } },
		opts = {
			position = 'right',
		},
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		opts = {
			scope = {
				enabled = true,
				show_start = false,
				-- highlight = 'Function',
				include = {
					node_type = { ['*'] = { '*' } },
				},
			},
		},
	},
}
