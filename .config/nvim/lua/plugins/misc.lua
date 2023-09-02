

return {
	{
		'mrjones2014/legendary.nvim',
		priority = 10000,
		lazy = false,
		opts = {
			lazy_nvim = {
				auto_register = true,
			},
			which_key = {
				auto_register = true,
			},
			extensions = {
				nvim_tree = true,
			},
		}
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
			opts.space_char_blankline = ' '
			opts.show_current_context = true
			opts.show_current_context_start = true
		end
	}
}
