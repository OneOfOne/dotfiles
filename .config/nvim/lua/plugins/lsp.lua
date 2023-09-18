return {
	{
		'neovim/nvim-lspconfig',
		opts = {
			-- format_notify = true,
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
			},
			formatting = {
				disabled = {
					'tsserver',
				},
			},
			servers = {
				tsserver = {
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
					end,
				},
				biome = {},
				marksman = {},
			},
		},
	},
	{
		'stevearc/conform.nvim',
		enabled = false,
		opts = {
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { 'stylua' },
				sh = { 'shfmt' },
				javascript = { 'biome' },
				javascriptreact = { 'biome' },
				typescript = { 'biome' },
				typescriptreact = { 'biome' },
			},
		},
	},
	{
		'jose-elias-alvarez/null-ls.nvim',
		enabled = false,
		opts = function(_, opts)
			local biome = require('null-ls').builtins.formatting.rome.with({
				command = 'biome',
			})
			opts.sources = vim.list_extend(opts.sources or {}, {
				biome,
			})
		end,
	},
}
