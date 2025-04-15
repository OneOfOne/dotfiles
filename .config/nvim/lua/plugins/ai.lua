vim.g.copilot_settings = { selectedCompletionModel = 'gpt-4o-copilot' }

return {
	{
		'zbirenbaum/copilot.lua',
		opts = function(_, opts)
			---@diagnostic disable-next-line: inject-field
			require('copilot.api').status = require('copilot.status')
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
