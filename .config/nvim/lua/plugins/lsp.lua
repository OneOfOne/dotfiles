vim.api.nvim_create_autocmd(
	"BufWritePre",
	{
		pattern = { "*.tsx,*.ts,*.jsx,*.js,*.vue" },
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
	}

}
