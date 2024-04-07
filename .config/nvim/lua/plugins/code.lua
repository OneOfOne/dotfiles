return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
		opts = {
			format_notify = true,

			inlay_hints = {
				enabled = false,
			},
			codelens = {
				enabled = true,
			},
			showMessage = {
				messageActionItem = {
					additionalPropertiesSupport = true,
				},
			},
			flags = {
				debounce_text_changes = 350,
				allow_incremental_sync = true,
			},
			servers = {
				jsonls = {
					commands = {
						Format = {
							function() end,
						},
					},
					json = {
						format = {
							enable = false,
						},
					},
				},
				biome = {},
			},
		},
	},
	{
		'nvimtools/none-ls.nvim',
		opts = function(_, opts)
			local nls = require('null-ls').builtins
			opts.sources = { --override lazyvim's default sources
				-- nls.code_actions.gitsigns,
				-- go
				nls.code_actions.gomodifytags,
				nls.code_actions.impl,
				nls.formatting.goimports,
				nls.diagnostics.golangci_lint,
				-- ts
				nls.formatting.biome.with({
					filetypes = { 'javascript', 'javascriptreact', 'json', 'jsonc', 'typescript', 'typescriptreact' },
					args = {
						'check',
						'--apply-unsafe',
						'--formatter-enabled=true',
						'--organize-imports-enabled=true',
						'--skip-errors',
						'$FILENAME',
					},
				}),
				-- other
				nls.formatting.stylua,
				nls.formatting.shfmt.with({
					filetypes = { 'sh', 'zsh' },
				}),
			}
			return opts
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {
			sync_install = false,
			textobjects = {
				swap = {
					enable = true,
					swap_next = {
						['[a'] = '@parameter.inner',
					},
					swap_previous = {
						[']a'] = '@parameter.inner',
					},
				},
				lsp_interop = {
					enable = true,
					border = 'none',
					floating_preview_opts = {},
					peek_definition_code = {
						['<leader>df'] = '@function.outer',
						['<leader>dF'] = '@class.outer',
					},
				},
			},
		},
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		branch = 'canary',
		dependencies = {
			{ 'zbirenbaum/copilot.lua' },
			{ 'nvim-lua/plenary.nvim' },
		},
		keys = {
			{
				'<leader>ah',
				function()
					local actions = require('CopilotChat.actions')
					require('CopilotChat.integrations.telescope').pick(actions.help_actions())
				end,
				desc = 'CopilotChat - Help actions',
			},
			-- Show
			{
				'<leader>ap',
				function()
					local actions = require('CopilotChat.actions')
					require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
				end,
				desc = 'CopilotChat - Prompt actions',
			},
			{
				'<leader>ac',
				function()
					local input = vim.fn.input('Quick Chat: ')
					if input ~= '' then
						require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
					end
				end,
				desc = 'CopilotChat - Quick chat',
			},
			{ '<leader>ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
			{ '<leader>at', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
			{ '<leader>ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
			{ '<leader>aR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
			{ '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
			{
				'<leader>am',
				'<cmd>CopilotChatCommit<cr>',
				desc = 'CopilotChat - Generate commit message for all changes',
			},
			{
				'<leader>aM',
				'<cmd>CopilotChatCommitStaged<cr>',
				desc = 'CopilotChat - Generate commit message for staged changes',
			},
			{ '<leader>af', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
			{ '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
		},
		opts = {
			window = {
				layout = 'float',
				relative = 'cursor',
				width = 0.5,
				height = 0.4,
				row = 1,
			},
			show_help = true,
			debug = false,
		},
		config = function(_, opts)
			local chat = require('CopilotChat')
			local select = require('CopilotChat.select')
			opts.selection = select.unnamed
			chat.setup(opts)

			vim.api.nvim_create_autocmd('BufEnter', {
				pattern = 'copilot-*',
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = true

					local ft = vim.bo.filetype
					if ft == 'copilot-chat' then
						vim.bo.filetype = 'markdown'
					end
				end,
			})
		end,
	},
}
