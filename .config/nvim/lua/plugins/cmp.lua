local types = require('cmp.types')

---@type table<integer, integer>
local modified_priority = {
	[types.lsp.CompletionItemKind.Keyword] = 1,
	[types.lsp.CompletionItemKind.Value] = 1,
	[types.lsp.CompletionItemKind.EnumMember] = 1,
	[types.lsp.CompletionItemKind.Variable] = 2,
	[types.lsp.CompletionItemKind.Field] = 2,
	[types.lsp.CompletionItemKind.Method] = 3,
	[types.lsp.CompletionItemKind.Function] = 5,
	[types.lsp.CompletionItemKind.Text] = 90,
	[types.lsp.CompletionItemKind.Snippet] = 100,
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
	if rust_trait(e) then
		kind = kind + 1
	end

	-- print(kind, e.source.name)

	return kind
end

local function sort_by_name(e1, e2) -- sort by length ignoring "=~"
	local n1 = e1.completion_item.label or e1.completion_item.sortText
	local n2 = e2.completion_item.label or e2.completion_item.sortText
	if n1 and n2 and n1 ~= n2 then
		return n1 < n2
	end
end

local function sort_by_kind(e1, e2)
	local k1 = modified_kind(e1)
	local k2 = modified_kind(e2)
	if k1 ~= k2 then
		return k1 < k2
	end
end

return {
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'onsails/lspkind.nvim',
			{
				'windwp/nvim-autopairs',
				event = 'InsertEnter',
				opts = {
					check_ts = true,
					map_cr = false,
					map_bs = false,
					enable_check_bracket_line = false,
					ignored_next_char = '[%w%.]',
					fast_wrap = {},
				},
			},
		},

		opts = function(_, opts)
			local cmp = require('cmp')

			opts.preselect = cmp.PreselectMode.None

			-- opts.matching = {
			-- 	disallow_fuzzy_matching = true,
			-- 	disallow_fullfuzzy_matching = true,
			-- 	disallow_partial_fuzzy_matching = true,
			-- 	disallow_partial_matching = true,
			-- 	disallow_prefix_unmatching = false,
			-- }

			opts.completion = {
				-- autocomplete = false, -- controlled in autocmds.lua
				completeopt = 'menu,menuone,noinsert,noselect',
			}
			--
			-- opts.performance = {
			-- 	async_budget = 1,
			-- 	debounce = 250,
			-- 	throttle = 250,
			-- 	max_view_entries = 100,
			-- }

			local compare = require('cmp.config.compare')
			opts.sorting = {
				-- thank you https://github.com/pysan3/dotfiles/blob/9d3ca30baecefaa2a6453d8d6d448d62b5614ff2/nvim/lua/plugins/70-nvim-cmp.lua#L39-L49
				comparators = {
					compare.offset,
					compare.exact,
					sort_by_kind,
					sort_by_name,
					compare.score,
				},
			}
			--
			-- opts.sources = cmp.config.sources({
			-- 	{ name = 'copilot' },
			--
			-- 	{ name = 'nvim_lsp' },
			-- 	{ name = 'crates' },
			-- }, {
			-- 	{ name = 'buffer' },
			-- 	{ name = 'path' },
			-- })

			opts.mapping = vim.tbl_extend('force', opts.mapping, {
				['<CR>'] = cmp.mapping.confirm({ select = false }),
			})

			local cmp_window = require('cmp.config.window')
			opts.window = {
				completion = cmp_window.bordered(),
				documentation = cmp_window.bordered(),
			}

			opts.experimental = {}

			-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
}
