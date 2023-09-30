local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

return {
	{
		'L3MON4D3/LuaSnip',
		keys = function()
			return {}
		end,
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {
			check_ts = true,
		},
	},
	{ 'windwp/nvim-ts-autotag', config = true },
	{
		'hrsh7th/nvim-cmp',

		dependencies = {
			'hrsh7th/cmp-emoji',
			'onsails/lspkind.nvim',
		},

		opts = function(_, opts)
			local cmp = require('cmp')
			local luasnip = require('luasnip')
			local types = require('cmp.types')
			local lspkind = require('lspkind')

			opts.preselect = cmp.PreselectMode.None

			opts.performance = {
				debounce = 150,
				throttle = 150,
				fetching_timeout = 500,
				confirm_resolve_timeout = 80,
				async_budget = 1,
				max_view_entries = 200,
			}

			opts.completion = {
				completeopt = 'menu,menuone,noselect,noinsert',
			}

			opts.formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol_text',
					menu = {
						buffer = '[Buf]',
						nvim_lsp = '[LSP]',
						luasnip = '[Snip]',
						treesitter = '[TS]',
					},
				}),
			}

			opts.sorting = {
				priority_weight = 2,
				comparators = {
					function(entry1, entry2)
						local kind1 = entry1:get_kind()
						kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
						local kind2 = entry2:get_kind()
						kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
						if kind1 ~= kind2 then
							if kind1 == types.lsp.CompletionItemKind.Snippet then
								return false
							end
							if kind2 == types.lsp.CompletionItemKind.Snippet then
								return true
							end
							local diff = kind1 - kind2
							return diff < 0
						end
					end,
					-- cmp.config.compare.offset,
					-- cmp.config.compare.exact,
					-- cmp.config.compare.score,
					-- cmp.config.compare.order,
					-- cmp.config.compare.sort_text,
					-- cmp.config.compare.length,
				},
			}

			opts.sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'copilot' },
				{ name = 'crates' },
				{ name = 'luasnip' },
				{ name = 'buffer' },
				{ name = 'path' },
				{ name = 'emoji' },
			})

			opts.mapping = vim.tbl_extend('force', opts.mapping, {
				-- ['<Up>'] = cmp.mapping.select_prev_item(),
				-- ['<Down>'] = cmp.mapping.select_next_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				--['<esc>'] = cmp.mapping.abort(),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				['<CR>'] = cmp.mapping.confirm({ select = false }),
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { 'i', 's' }),

				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			})

			local cmp_window = require('cmp.config.window')
			opts.window = {
				completion = cmp_window.bordered(),
				documentation = cmp_window.bordered(),
			}

			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
}
