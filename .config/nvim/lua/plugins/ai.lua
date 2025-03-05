return {
	{
		'milanglacier/minuet-ai.nvim',
		lazy = false,
		enabled = false,
		config = function()
			require('minuet').setup({
				after_cursor_filter_length = 20,
				notify = 'error',
				provider = 'openai_fim_compatible',
				provider_options = {
					openai_fim_compatible = {
						api_key = 'TERM',
						name = 'Ollama',
						end_point = 'http://localhost:11434/v1/completions',
						model = 'qwen2.5-coder:14b',
						stream = false,
						optional = {
							max_tokens = 256,
							top_p = 0.9,
						},
					},
				},
			})
		end,
	},
	{
		'olimorris/codecompanion.nvim',
		priority = 999,
		enabled = false,
		event = 'LspAttach',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			{ 'echasnovski/mini.diff', opts = {} },
		},
		keys = {
			{
				'<leader>ad',
				'<cmd>CodeCompanion /buffer you are an expert in writing documentation, please write documentation above the selected code<cr>',
				mode = 'v',
				desc = 'Generate documentation',
			},
		},
		opts = {
			adapters = {
				qwencoder = function()
					return require('codecompanion.adapters').extend('ollama', {
						name = 'qwencoder', -- Give this adapter a different name to differentiate it from the default ollama adapter
						schema = {
							model = {
								default = 'qwen2.5-coder:14b-instruct-q8_0',
							},
							num_ctx = {
								default = 32768,
							},
						},
					})
				end,
			},
			display = {
				inline = {
					layout = 'buffer', -- vertical|horizontal|buffer
				},
				diff = {
					provider = 'mini_diff',
				},
			},
			strategies = {
				chat = { adapter = 'qwencoder' },
				inline = { adapter = 'qwencoder' },
			},
		},
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		ft = { 'markdown', 'codecompanion' },
	},
}
