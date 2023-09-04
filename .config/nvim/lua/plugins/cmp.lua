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
			-- "hrsh7th/cmp-emoji",
		},
		opts = function(_, opts)
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.preselect = cmp.PreselectMode.None

			opts.completion = {
				autocomplete = false,
			}

			opts.sources = {
				{ name = "nvim_lsp" },
				{ name = "copilot" },
				{ name = "crates" },
				{ name = "luasnip" },
				{ name = "calc" },
				{ name = "buffer" },
				{ name = "path" },
			}

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				["<esc>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i" }),
			})

			local cmp_window = require("cmp.config.window")
			opts.window = {
				completion = cmp_window.bordered(),
				documentation = cmp_window.bordered(),
			}
		end,
	}
}
