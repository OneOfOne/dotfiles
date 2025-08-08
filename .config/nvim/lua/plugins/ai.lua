return {
	{
		'zbirenbaum/copilot.lua',
		optional = true,
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
		event = 'LspAttach',
		dependencies = {
			'MunifTanjim/nui.nvim',
			{
				'MeanderingProgrammer/render-markdown.nvim',
				opts = { file_types = { 'markdown', 'Avante' } },
				ft = { 'markdown', 'Avante' },
			},
		},
		build = 'make',
		opts = {
			provider = 'copilot',
			hints = { enabled = false },
			input = {
				provider = 'snacks', -- "native" | "dressing" | "snacks"
				provider_opts = {
					-- Snacks input configuration
					title = 'Avante Input',
					icon = ' ',
					placeholder = 'Enter your API key...',
				},
			},
		},
	},
}
