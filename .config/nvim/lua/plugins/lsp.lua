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
			servers = {
				tsserver = {
					format = {
						enable = false,
					},
				},
				rome = {},
				marksman = {},
			},
		},
	},
}
