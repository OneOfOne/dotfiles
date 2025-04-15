return {
	{
		'saghen/blink.cmp',
		optional = true,
		opts_extend = {
			'sources.default',
		},
		opts = {
			completion = {
				accept = { auto_brackets = { enabled = false } },
				menu = {
					draw = {
						padding = 1,
						treesitter = { 'lsp' },
						columns = {
							{ 'kind_icon' },
							{ 'label', 'label_description', gap = 1 },
							{ 'source_name' },
						},
					},
				},
				list = {
					selection = { preselect = false, auto_insert = false },
					cycle = {
						-- from_top = false,
					},
				},
				trigger = { prefetch_on_insert = false },
			},
			signature = {
				enabled = true,
				window = {
					scrollbar = true,
				},
			},
			fuzzy = {},
			sources = {
				-- default = { 'lsp', 'path', 'buffer', 'minuet' },
				providers = {
					-- minuet = {
					-- 	name = 'minuet',
					-- 	module = 'minuet.blink',
					-- 	score_offset = 8, -- Gives minuet higher priority among suggestions
					-- },
					path = {
						module = 'blink.cmp.sources.path',
						opts = {
							show_hidden_files_by_default = true,
						},
					},
				},
			},
		},
	},
}
