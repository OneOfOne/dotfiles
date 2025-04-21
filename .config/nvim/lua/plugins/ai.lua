return {
	{
		'zbirenbaum/copilot.lua',
		optional = true,
		opts = function(_, opts)
			opts.copilot_model = 'gpt-4o-copilot'
		end,
	},
	{
		'giuxtaposition/blink-cmp-copilot',
		enabled = false,
	},
	{
		'saghen/blink.cmp',
		dependencies = { 'fang2hou/blink-copilot' },
		opts = {
			sources = {
				providers = {
					copilot = {
						module = 'blink-copilot',
					},
				},
			},
		},
	},
	{
		'yetone/avante.nvim',
		event = 'VeryLazy',
		dependencies = {
			'MunifTanjim/nui.nvim',
			{
				'MeanderingProgrammer/render-markdown.nvim',
				opts = { file_types = { 'markdown', 'Avante' } },
				ft = { 'markdown', 'Avante' },
			},
		},
		build = 'make',
		opts = { provider = 'copilot' },
	},
}
