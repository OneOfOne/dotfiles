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
						model = 'qwen2.5-coder:3b',
						end_point = 'http://127.0.0.1:11434/v1/completions',
						name = 'Ollama',
						stream = false,
						api_key = 'LANG',
						max_tokens = 16384,
						optional = {
							stop = nil,
							max_tokens = nil,
						},
					},
				},
			})
		end,
	},
	{
		'olimorris/codecompanion.nvim',
		priority = 999,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			{ 'echasnovski/mini.diff', opts = {} },
		},
		keys = {
			{
				'<leader>ad',
				'<cmd>CodeCompanion /buffer please write documentation for the selected code and append it above it<cr>',
				mode = 'v',
				desc = 'Generate documentation',
			},
		},
		opts = {
			--Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
			display = {
				inline = {
					layout = 'buffer', -- vertical|horizontal|buffer
				},
				diff = {
					provider = 'mini_diff',
				},
			},
			strategies = {
				--NOTE: Change the adapter as required
				chat = { adapter = 'copilot' },
				inline = { adapter = 'copilot' },
			},
			opts = {
				log_level = 'DEBUG',
			},
		},
	},
}
