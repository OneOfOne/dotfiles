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
			-- print(vim.inspect(opts))
			opts.sources = { --override lazyvim's default sources
				nls.builtins.code_actions.gitsigns,
				-- go
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
				-- nls.builtins.diagnostics.golangci_lint,
				-- ts
				nls.builtins.formatting.biome,
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
		main = 'ibl',
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
