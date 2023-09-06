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
				debounce_text_changes = 100,
			},
			formatting = {
				disabled = {
					"tsserver",
				},
			},
			servers = {
				tsserver = {
					 on_attach = function(client, bufnr)
						client.server_capabilities.documentFormattingProvider = false
					end,
				},
				rome = {},
				marksman = {},
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = {
			sources = {
				require("null-ls").builtins.formatting.rome
			},
		},
	},
}

