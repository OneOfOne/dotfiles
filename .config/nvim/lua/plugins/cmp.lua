local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_kinds = {
	Text = '  ',
	Method = '  ',
	Function = '  ',
	Constructor = '  ',
	Field = '  ',
	Variable = '  ',
	Class = '  ',
	Interface = '  ',
	Module = '  ',
	Property = '  ',
	Unit = '  ',
	Value = '  ',
	Enum = '  ',
	Keyword = '  ',
	Snippet = '  ',
	Color = '  ',
	File = '  ',
	Reference = '  ',
	Folder = '  ',
	EnumMember = '  ',
	Constant = '  ',
	Struct = '  ',
	Event = '  ',
	Operator = '  ',
	TypeParameter = '  ',
}

return {
	{
		'L3MON4D3/LuaSnip',
		keys = function()
			return {}
		end,
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-emoji',
			'onsails/lspkind.nvim',
		},
		opts = function(_, opts)
			local cmp = require('cmp')
			local luasnip = require("luasnip")
			local lspkind = require('lspkind')
			opts.formatting = {
				-- format = lspkind.cmp_format(),
				format = function(_, vim_item)
					vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
					return vim_item
				end,
			}

			opts.preselect = cmp.PreselectMode.None

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
				{ name = 'copilot' },
				{ name = 'nvim_lsp' },
				{ name = 'crates' },
				{ name = 'cmp-nvim-lsp-signature-help' },
				{ name = 'luasnip' },
				{ name = 'buffer' },
				{ name = 'path' },
				{ name = 'emoji' },
			})

			opts.mapping = vim.tbl_extend('force', opts.mapping, {
				['<Up>'] = cmp.mapping.select_prev_item(),
				['<Down>'] = cmp.mapping.select_next_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
				['<esc>'] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
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

			local cmp_window = require('cmp.config.window')
			opts.window = {
				completion = cmp_window.bordered(),
				documentation = cmp_window.bordered(),
			}
		end,
	}
}
