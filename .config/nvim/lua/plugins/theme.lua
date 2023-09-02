-- local float = { focusable = true, style = "minimal", border = "rounded", }
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			show_end_of_buffer = true,
			term_colors = true,
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
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
		"nvim-lualine/lualine.nvim",
		opts = {
			sections = {
				lualine_y = {
					{ "searchcount", separator = " ", padding = { left = 1, right = 0 } },
					{ "selectioncount", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
			}
		}
	}
}
