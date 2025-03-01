return {
	{
		'folke/snacks.nvim',
		optional = true,
		keys = {
			{
				'<c-tab>',
				function()
					Snacks.picker.buffers({ current = false, sort_lastused = true, layout = { preset = 'select' } })
				end,
				desc = 'buffer switcher',
			},
		},
		---@type snacks.Config
		opts = {
			picker = {
				sources = {
					files = { hidden = true },
					grep = { hidden = true },
					explorer = { hidden = true },
				},
				layouts = {
					select = {
						preview = nil,
						layout = {
							backdrop = false,
							width = 0.4,
							min_width = 10,
							height = 0.4,
							min_height = 10,
							box = 'vertical',
							border = 'rounded',
							-- title = ' Select ',
							title_pos = 'center',
							{ win = 'input', height = 1, border = 'bottom' },
							{ win = 'list', border = 'none' },
						},
					},
				},
				win = {
					input = {
						keys = {
							['<Tab>'] = { 'list_down', mode = { 'i', 'n' } },
							['<S-Tab>'] = { 'list_up', mode = { 'i', 'n' } },
						},
					},
					list = {
						keys = {
							['<Tab>'] = 'list_down',
							['<S-Tab>'] = 'list_up',
						},
					},
				},
			},

			input = {
				win = {},
			},
			image = {
				enabled = true,
				force = true,
			},
			statuscolumn = {
				enabled = true,
				folds = {
					open = true,
					git_hl = true,
				},
			},
			indent = {
				enabled = true,
				chunk = {
					enabled = true,
				},
				blank = {
					char = ' ',
				},
			},
		},
	},
}
