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
				rust_analyzer = {},
				biome = {},
				marksman = {},
			},
		},
	},
	{
		'nvimtools/none-ls.nvim',
		opts = function(_, opts)
			local nls = require('null-ls')
			opts.sources = opts.sources or {}
			vim.list_extend(opts.sources, {
				-- nls.builtins.completion.luasnip,
				nls.builtins.code_actions.gitsigns,
				-- go
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
				-- ts
				nls.builtins.formatting.biome,
				require("typescript.extensions.null-ls.code-actions")
			})
			return opts
		end,
	},
}
