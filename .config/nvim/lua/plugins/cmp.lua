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
			appearance = {
				nerd_font_variant = 'normal',
			},
			completion = {
				menu = {
					draw = {
						padding = 1,
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
			cmdline = {
				keymap = { preset = 'inherit' },
			},
			fuzzy = {},
			sources = {},
		},
	},
}
