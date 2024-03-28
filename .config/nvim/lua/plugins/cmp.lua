local types = require('cmp.types')

---@type table<integer, integer>
local modified_priority = {
	[types.lsp.CompletionItemKind.Keyword] = 1, -- top
	[types.lsp.CompletionItemKind.Variable] = 2,
	[types.lsp.CompletionItemKind.Field] = 2,
	[types.lsp.CompletionItemKind.Method] = 3,
	[types.lsp.CompletionItemKind.Function] = 3,
	[types.lsp.CompletionItemKind.Text] = 90, -- bottom
	[types.lsp.CompletionItemKind.Snippet] = 100, -- top
}

local function rust_trait(e)
	local ci = e.completion_item
	if ci.labelDetails ~= nil and ci.labelDetails.detail ~= nil then
		local ld = ci.labelDetails.detail
		return string.find(ld, '^ %(use ') ~= nil or string.find(ld, '^ %(as ') ~= nil
	end
end

local function modified_kind(e)
	local kind = e:get_kind()
	kind = modified_priority[kind] or kind

	if e.source.name == 'copilot' then
		kind = 0
	end

	-- rust traits after methods/functions
	if kind == 3 and rust_trait(e) then
		kind = 4
	end

	-- print(kind, e.source.name)

	return kind
end

local function sort_by_name(e1, e2) -- sort by length ignoring "=~"
	local n1 = string.gsub(e1.completion_item.label, '[=~()_,. ]', '')
	local n2 = string.gsub(e2.completion_item.label, '[=~()_,. ]', '')
	if n1 and n2 then
		return n1 < n2
	end
end

local function sort_by_kind(e1, e2)
	local k1 = modified_kind(e1)
	local k2 = modified_kind(e2)
	if k1 ~= k2 then
		return k1 - k2 < 0
	end
end

return {
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
			'onsails/lspkind.nvim',
			-- 'chrisgrieser/cmp_yanky',
		},

		opts = function(_, opts)
			local cmp = require('cmp')
			local lspkind = require('lspkind')

			opts.preselect = cmp.PreselectMode.None
			opts.experimental = {
				ghost_text = {
					hl_group = 'CmpGhostText',
				},
			}
			opts.performance = {
				debounce = 350,
				throttle = 350,
				fetching_timeout = 350,
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

			local compare = cmp.config.compare

			opts.sorting = {
				-- thank you https://github.com/pysan3/dotfiles/blob/9d3ca30baecefaa2a6453d8d6d448d62b5614ff2/nvim/lua/plugins/70-nvim-cmp.lua#L39-L49
				comparators = {
					sort_by_kind,
					sort_by_name,
				},
			}

			opts.sources = cmp.config.sources({
				{ name = 'copilot' },
				{ name = 'nvim_lsp' },
				{ name = 'crates' },
			}, {
				{ name = 'buffer' },
				{ name = 'path' },
			})

			opts.mapping = vim.tbl_extend('force', opts.mapping, {
				['<Esc>'] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				['<CR>'] = cmp.mapping.confirm({ select = false }),
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
