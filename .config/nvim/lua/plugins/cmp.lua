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
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.preselect = cmp.PreselectMode.None

			opts.completion = {
				keyword_length = 2,
				-- autocomplete = false,
			}

			opts.performance = {
				debounce = 26,
				throttle = 48,
				fetching_timeout = 200,
				async_budget = 50,
				max_view_entries = 32,
			}

			opts.sorting = {
				priority_weight = 3,
				comparators = {
					-- cmp.config.compare.offset,
					cmp.config.compare.score,
					cmp.config.compare.order,
					cmp.config.compare.kind,
					cmp.config.compare.exact,
					cmp.config.compare.recently_used,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
				}
			}
			opts.sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "crates" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "emoji" },
			})

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				['<Up>'] = cmp.mapping.select_prev_item(),
				['<Down>'] = cmp.mapping.select_next_item(),
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping({
					-- i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					i = function(fallback)
						if cmp.visible() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					c = function(fallback)
						if cmp.visible() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end
				}),
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
