return {
	{
		'echasnovski/mini.pairs',
		enabled = false,
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {
			check_ts = false,
			map_cr = true,
			map_bs = false,
			enable_check_bracket_line = false,
			ignored_next_char = '[%w%.]',
			fast_wrap = {},
		},
		config = function(_, cfg)
			require('nvim-autopairs').setup(cfg)
			-- local npairs = require('nvim-autopairs')
			-- local Rule = require('nvim-autopairs.rule')
			-- local cond = require('nvim-autopairs.conds')
			-- npairs.get_rules("'")[1]:with_pair(cond.not_after_text('['))
		end,
	},
}
