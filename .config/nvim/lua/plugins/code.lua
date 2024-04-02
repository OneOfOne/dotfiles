return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
		opts = {
			format_notify = true,

			inlay_hints = {
				enabled = true,
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
				-- jsonls = {
				-- 	settings = {
				-- 		json = {
				-- 			format = {
				-- 				enable = false,
				-- 			},
				-- 		},
				-- 	},
				-- },
				vtsls = {
					keys = {
						{
							'<leader>co',
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { 'source.organizeImports.ts' },
										diagnostics = {},
									},
								})
							end,
							desc = 'Organize Imports',
						},
						{
							'<leader>cR',
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { 'source.removeUnused.ts' },
										diagnostics = {},
									},
								})
							end,
							desc = 'Remove Unused Imports',
						},
					},
					settings = {
						completions = {
							completeFunctionCalls = true,
						},
						javascript = {
							format = {
								enable = false,
							},
						},
						typescript = {
							format = {
								enable = false,
							},
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
				-- nls.formatting.biome.with({
				-- 	args = {
				-- 		'check',
				-- 		'--apply',
				-- 		'--formatter-enabled=true',
				-- 		'--organize-imports-enabled=true',
				-- 		'--skip-errors',
				-- 		'$FILENAME',
				-- 	},
				-- }),
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
			{ 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
			{ 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
		},
		keys = {
			{
				'<leader>cpp',
				function()
					local actions = require('CopilotChat.actions')
					require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
				end,
				desc = 'CopilotChat - Prompt actions',
			},
			{
				'<leader>cpc',
				function()
					local input = vim.fn.input('Quick Chat: ')
					if input ~= '' then
						require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
					end
				end,
				desc = 'CopilotChat - Quick chat',
			},
		},
		opts = {
			window = {
				layout = 'float',
				relative = 'cursor',
				width = 0.5,
				height = 0.4,
				row = 1,
			},
			debug = false,
		},
	},
}
