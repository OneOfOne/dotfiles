vim.api.nvim_create_autocmd(
	"BufWritePre",
	{
		pattern = { "*.tsx,*.ts,*.mts,*.jsx,*.js,*.mjs,*.cjs,*.vue" },
		callback = function()
			vim.lsp.buf.format({
				async = false,
				-- only use null-ls
				filter = function(client) return client.name == "null-ls" end
			})
		end
	}
)

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- format_notify = true,
			format = {
				filter = function(client)
					return client.name ~= "tsserver"
				end
			},
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
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			vim.list_extend(opts.sources, {
				nls.builtins.formatting.rome,
			})
		end
	},
}
