return {
	{
		'folke/snacks.nvim',
		optional = true,
		keys = {
			{
				'<c-tab>',
				function()
					---@diagnostic disable-next-line: missing-fields
					Snacks.picker.buffers({ current = false, layout = { preview = false, preset = 'select' } })
				end,
				desc = 'buffer switcher',
			},
		},
		opts = {
			statuscolumn = {
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
			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
		},
	},
}
