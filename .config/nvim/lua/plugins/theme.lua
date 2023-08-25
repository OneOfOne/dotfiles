local float = { focusable = true, style = "minimal", border = "rounded", }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

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
			integrations = {
				dap = { enabled = true, enable_ui = true },
				harpoon = true,
				gitsigns = true,
				mason = true,
				neotree = true,
				neotest = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				symbols_outline = true,
				treesitter = true,
				treesitter_context = true,
				telescope = true,
				lsp_trouble = true,
				which_key = true,
			},
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},
}
