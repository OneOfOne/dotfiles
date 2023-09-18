-- local float = { focusable = true, style = 'minimal', border = 'rounded', }
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float)
-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		opts = {
			color_overrides = {
				mocha = { -- custom
					rosewater = "#ffc6be",
					flamingo = "#fb4934",
					pink = "#ff75a0",
					mauve = "#f2594b",
					red = "#f2594b",
					maroon = "#fe8019",
					peach = "#FFAD7D",
					yellow = "#e9b143",
					green = "#b0b846",
					teal = "#8bba7f",
					sky = "#7daea3",
					sapphire = "#689d6a",
					blue = "#80aa9e",
					lavender = "#e2cca9",
					text = "#e2cca9",
					subtext1 = "#e2cca9",
					subtext0 = "#e2cca9",
					overlay2 = "#8C7A58",
					overlay1 = "#735F3F",
					overlay0 = "#806234",
					surface2 = "#665c54",
					surface1 = "#3c3836",
					surface0 = "#32302f",
					base = "#282828",
					mantle = "#1d2021",
					crust = "#1b1b1b",

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
		opts = {
			options = {
				always_show_bufferline = true,
				themable = true,
				separator_style = 'slope',
			},
		}
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			sections = {
				lualine_y = {
					{ 'searchcount',    separator = ' ',                  padding = { left = 1, right = 0 } },
					{ 'selectioncount', separator = ' ',                  padding = { left = 1, right = 0 } },
					{ 'location',       padding = { left = 0, right = 1 } },
				},
			}
		}
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		branch = 'v3',
		opts = function(_, opts)
			local hooks = require('ibl.hooks')
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
			end)
			opts.scope = {
				enabled = true,
				char = '│',
				show_start = false,
				highlight = { 'RainbowOrange' }
			}
			opts.indent = { highlight = { 'NeoTreeIndentMarker' } }
		end,
		config = function(_, opts)
			local hooks = require('ibl.hooks')
			require('ibl').setup(opts)
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	}

}
