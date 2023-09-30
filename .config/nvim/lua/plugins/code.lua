vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	update_in_insert = true,
})

local function disableFmtProvider(client)
	client.server_capabilities.documentFormattingProvider = false
end

return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
		opts = {
			-- format_notify = true,
			inlay_hints = {
				enabled = false,
			},

			capabilities = vim.tbl_extend('force', require('cmp_nvim_lsp').default_capabilities(), {
				textDocument = {
					foldingRange = {
						dynamicRegistration = true,
						lineFoldingOnly = true,
					},
					completion = {
						completionItem = {
							snippetSupport = true,
						},
					},
				},
			}),

			showMessage = {
				messageActionItem = {
					additionalPropertiesSupport = true,
				},
			},

			flags = {
				debounce_text_changes = 150,
			},

			servers = {
				tsserver = {
					on_attach = disableFmtProvider,
				},

				gopls = {
					settings = {
						gopls = {
							semanticTokens = false,
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},

				html = {},
				biome = {},
				marksman = {},
			},
		},
	},
	{
		'nvimtools/none-ls.nvim',
		opts = function(_, opts)
			local nls = require('null-ls')
			opts.sources = { --override lazyvim's default sources
				nls.builtins.code_actions.gitsigns,
				-- go
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
				-- nls.builtins.diagnostics.golangci_lint,
				-- ts
				nls.builtins.formatting.biome.with({
					args = {
						'check',
						'--apply-unsafe',
						'--formatter-enabled=true',
						'--organize-imports-enabled=true',
						'--skip-errors',
						'$FILENAME',
					},
					ignore_stdout = true,
					ignore_stderr = true,
					to_temp_file = false,
				}),
				on_output = function(_, done)
					done()
				end,
				-- other
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.shfmt.with({
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
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<BS>',
					node_incremental = '<BS>',
					scope_incremental = '<C-BS>',
					node_decremental = '<A-BS>',
				},
			},
		},
	},
}
