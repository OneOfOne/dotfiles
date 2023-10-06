local function has_words_before()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local function cmp_snippts_last(entry1, entry2)
	local types = require('cmp.types')
	-- https://www.reddit.com/r/neovim/comments/woih9n/comment/ikbd6iy/?utm_source=reddit&utm_medium=web2x&context=3
	if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
		return false
	end
	if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
		return true
	end
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
	{
		'hrsh7th/nvim-cmp',

		dependencies = {
			'hrsh7th/cmp-emoji',
			'onsails/lspkind.nvim',
		},

		opts = function(_, opts)
			local cmp = require('cmp')
			-- local luasnip = require('luasnip')
			local lspkind = require('lspkind')

			opts.preselect = cmp.PreselectMode.None

			opts.performance = {
				debounce = 150,
				throttle = 150,
				fetching_timeout = 250,
				confirm_resolve_timeout = 80,
				async_budget = 1,
				max_view_entries = 100,
			}

			opts.completion = {
				completeopt = 'menu,menuone,noselect,noinsert',
				keyword_length = 2,
			}

			opts.formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol_text',
					--menu = {},
				}),
			}

			opts.sorting = {
				priority_weight = 2,
				comparators = {
					cmp_snippts_last,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					-- cmp.config.compare.recently_used,
					cmp.config.compare.kind,
					-- cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			}

			opts.sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'crates' },
				{ name = 'copilot' },
			}, {
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
				['<Esc>'] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				['<CR>'] = cmp.mapping.confirm({ select = false }),
				-- ['<Down>'] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_next_item()
				-- 	elseif luasnip.expandable() then
				-- 		luasnip.expand()
				-- 	elseif luasnip.expand_or_jumpable() then
				-- 		luasnip.expand_or_jump()
				-- 	elseif has_words_before() then
				-- 		cmp.complete()
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { 'i', 's' }),
				-- ['<Up>'] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_prev_item()
				-- 	elseif luasnip.jumpable(-1) then
				-- 		luasnip.jump(-1)
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { 'i', 's' }),
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
