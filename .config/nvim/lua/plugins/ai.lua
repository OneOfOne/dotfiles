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
			provider = 'claude',
			-- hints = { enabled = false },
			providers = {
				claude = {
					endpoint = 'https://api.anthropic.com',
					model = 'claude-sonnet-4-20250514',
					timeout = 60000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
					api_key_name = 'cmd:kv-get get claude',
				},
			},
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
