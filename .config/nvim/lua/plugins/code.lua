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
			format_notify = true,
			inlay_hints = {
				enabled = false,
			},

			capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
					completion = {
						completionItem = {
							snippetSupport = true,
						},
					},
				},
			},

			showMessage = {
				messageActionItem = {
					additionalPropertiesSupport = true,
				},
			},

			flags = {
				debounce_text_changes = 150,
				allow_incremental_sync = true,
			},

			servers = {
				tsserver = {
					on_attach = disableFmtProvider,
				},
				rust_analyzer = {
					settings = {
						['rust-analyzer'] = {
							diagnostics = {
								enable = true,
								disabled = { 'unresolved-proc-macro' },
								enableExperimental = true,
							},
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								runBuildScripts = true,
								extraArgs = { '--no-capture ' },
							},
							-- Add clippy lints for Rust.
							checkOnSave = {
								allFeatures = true,
								command = 'clippy',
								extraArgs = { '--no-deps' },
							},
							procMacro = {
								enable = true,
								ignored = {
									['async-trait'] = { 'async_trait' },
									['napi-derive'] = { 'napi' },
									['async-recursion'] = { 'async_recursion' },
								},
							},
						},
					},
				},
				gopls = {
					settings = {
						gopls = {
							completeUnimported = true,
							semanticTokens = false,
							vulncheck = 'Imports',
							gofumpt = true,
							staticcheck = true,
							analyses = {
								ST1000 = false,
								ST1003 = false,
								SA5001 = false,
								nilness = true,
								unusedparams = false,
								unusuedwrite = true,
								useany = true,
								fieldalignment = true,
								shadow = false,
								composites = true,
							},

							usePlaceholders = false,

							allowImplicitNetworkAccess = true,
							directoryFilters = { '-node_modules', '-data' },

							experimentalPostfixCompletions = true,
						},
					},
				},

				cssls = {},
				html = {},
				biome = {},
				marksman = {},
			},
		},
	},
	{
		'nvimtools/none-ls.nvim',
		opts = function(_, opts)
			local nls = require('null-ls').builtins
			opts.sources = { --override lazyvim's default sources
				nls.code_actions.gitsigns,
				-- go
				nls.code_actions.gomodifytags,
				nls.code_actions.impl,
				nls.formatting.goimports,
				-- nls.diagnostics.golangci_lint,
				-- ts
				nls.formatting.biome.with({
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
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<BS>',
					node_incremental = '<BS>',
					scope_incremental = '<C-BS>',
					node_decremental = '<A-BS>',
				},
			},
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
			},
		},
	},
}
