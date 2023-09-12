return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- format_notify = true,
			inlay_hints = {
				enabled = true,
			},
			capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true
					},
					completion = {
						completionItem = {
							snippetSupport = true,
						},
					},
				}
			},
			showMessage = {
				messageActionItem = {
					additionalPropertiesSupport = true
				}
			},
			flags = {
				debounce_text_changes = 150,
			},
			formatting = {
				disabled = {
					"tsserver",
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
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local biome = require("null-ls").builtins.formatting.rome.with({
				command = "biome",
			})
			opts.sources = vim.list_extend(opts.sources or {}, {
				biome
			})
		end,
	},
}
