local keymap = require('blink.cmp.config.keymap')
return {
	{
		'zbirenbaum/copilot.lua',
		dependencies = {
			'copilotlsp-nvim/copilot-lsp',
		},
		optional = true,
		opts = {
			nes = {
				enabled = false,
				auto_trigger = true,
				keymap = {
					accept_and_goto = '<leader>p',
					accept = false,
					dismiss = '<Esc>',
				},
			},
		},
	},
	{
		'saghen/blink.cmp',
		dependencies = {
			'Kaiser-Yang/blink-cmp-avante',
		},
		opts = {
			sources = {
				-- Add 'avante' to the list
				default = { 'avante' },
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
			keymap = {
				['<c-cr>'] = {
					function(cmp)
						local nes = require('copilot-lsp.nes')
						if vim.b[vim.api.nvim_get_current_buf()].nes_state then
							cmp.hide()
							return (nes.apply_pending_nes() and nes.walk_cursor_end_edit())
						end
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					'fallback',
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
			prompt_logger = { -- logs prompts to disk (timestamped, for replay/debugging)
				enabled = false,
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
