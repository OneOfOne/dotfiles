return {
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
		},
		opts = function(_, opts)
			opts.sources = {
				{ name = "nvim_lsp" },
				{ name = "copilot" },
				{ name = "crates" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- this way you will only jump inside the snippet region
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					-- elseif has_words_before() then
					-- 	cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})

			local cmp_window = require("cmp.config.window")
			opts.window = {
				completion = cmp_window.bordered(),
				documentation = cmp_window.bordered(),
			}
		end,
	}
}
