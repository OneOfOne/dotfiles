return {
	{
		'saghen/blink.cmp',
		optional = true,
		version = '1.*',
		opts_extend = {
			'sources.default',
		},
		dependencies = {
			'Kaiser-Yang/blink-cmp-avante',
			-- ... Other dependencies
		},
		opts = {
			completion = {
				accept = { auto_brackets = { enabled = true } },
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
				default = { 'avante', 'lsp', 'path', 'buffer' },
				providers = {
					avante = {
						module = 'blink-cmp-avante',
						name = 'Avante',
						opts = {
							-- options for blink-cmp-avante
						},
					},
				},
			},
		},
	},
}
