

return {
	{
		"folke/trouble.nvim",
		opts = {
			auto_open = true,
			auto_close = true,
			use_diagnostic_signs = true,
		},
	},
	{
		'chentoast/marks.nvim',
		event = "BufReadPre",
		opts = {
			default_mappings = true,
			force_write_shada = false,
			refresh_interval = 250,
		},
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		-- enabled = false,
		opts = function(_, opts)
			vim.cmd [[
				highlight IndentBlanklineIndent1 guifg=#14e0d9 gui=nocombine
				highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
				highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
				highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
				highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
				highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
			]]

			opts.char_highlight_list = {
				'IndentBlanklineIndent1',
				'IndentBlanklineIndent2',
				'IndentBlanklineIndent3',
				'IndentBlanklineIndent4',
				'IndentBlanklineIndent5',
				'IndentBlanklineIndent6',
			}
			opts.show_trailing_blankline_indent = false
			opts.char_priority = 12
			opts.show_foldtext = false
			opts.use_treesitter = true
			opts.use_treesitter_scope = true
			opts.space_char_blankline = ' '
			opts.show_current_context = true
			opts.show_current_context_start = true
		end
	}
}
