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
	{ 'iguanacucumber/mag-nvim-lsp', name = 'cmp-nvim-lsp', opts = {} },
	{ 'iguanacucumber/mag-nvim-lua', name = 'cmp-nvim-lua' },
	{ 'iguanacucumber/mag-buffer', name = 'cmp-buffer' },
	{ 'iguanacucumber/mag-cmdline', name = 'cmp-cmdline' },
	{
		'iguanacucumber/magazine.nvim',
		name = 'nvim-cmp',
		-- disabled = true,
		-- dev = true,
		-- build = 'git clone https://github.com/iguanacucumber/magazine.nvim ~/projects/nvim-cmp/',

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

			opts.completion = {
				completeopt = 'menu,menuone,noinsert,noselect',
			}

			local compare = require('cmp.config.compare')
			opts.sorting = {
				-- thank you https://github.com/pysan3/dotfiles/blob/9d3ca30baecefaa2a6453d8d6d448d62b5614ff2/nvim/lua/plugins/70-nvim-cmp.lua#L39-L49
				comparators = {
					compare.offset,
					compare.exact,
					compare.score,
					sort_by_kind,
					sort_by_name,
					compare.recently_used,
					compare.locality,
					compare.sort_text,
					compare.length,
					compare.order,
				},
			}

			-- opts.sources = cmp.config.sources({
			-- 	{ name = 'cmp_ai' },
			-- })
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

			opts.experimental = {
				ghost_text = true,
			}

			-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
	{
		'saghen/blink.cmp',
		version = '*',
		enabled = false,
		opts_extend = { 'sources.completion.enabled_providers' },
		dependencies = {
			'rafamadriz/friendly-snippets',
			-- add blink.compat to dependencies
			{
				'saghen/blink.compat',
				opts = {
					impersonate_nvim_cmp = true,
					-- enable_events = true,
				},
			},
		},
		event = 'InsertEnter',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = false,
			},
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono',
			windows = {
				autocomplete = {
					draw = 'reversed',
					winblend = vim.o.pumblend,
				},
				documentation = {
					auto_show = true,
				},
				ghost_text = {
					enabled = true,
				},
			},

			-- experimental auto-brackets support
			accept = { auto_brackets = { enabled = true } },

			-- experimental signature help support
			trigger = { signature_help = { enabled = true } },
			sources = {
				completion = {
					-- remember to enable your providers here
					enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
				},
			},

			keymap = {
				preset = 'enter',
			},
		},
	},
}
