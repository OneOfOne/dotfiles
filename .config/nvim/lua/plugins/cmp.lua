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
	-- if ci ~= nil and ci.labelDetails ~= nil and ci.labelDetails.detail ~= nil then
	-- 	local ld = ci.labelDetails.detail
	-- 	return string.find(ld, '^ %(use ') ~= nil or string.find(ld, '^ %(as ') ~= nil
	-- end
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
	{ 'iguanacucumber/mag-buffer', name = 'cmp-buffer' },
	{ 'iguanacucumber/mag-cmdline', name = 'cmp-cmdline' },
	{ 'https://codeberg.org/FelipeLema/cmp-async-path', name = 'cmp-path' },
	{
		'iguanacucumber/magazine.nvim',
		name = 'nvim-cmp',
		version = false,
		-- enabled = false,
		-- dev = true,
		-- dir = '~/code/nvim/LazyVim',
		optional = true,

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
			-- 	{ name = 'copilot' },
			-- 	{ name = 'mineut' },
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
		end,
	},
	{
		'saghen/blink.cmp',
		optional = true,
		version = false,
		build = 'cargo build --release',
		dependencies = {
			-- {
			-- 	'saghen/blink.compat',
			-- 	enabled = false,
			-- 	opts = {
			-- 		-- some plugins lazily register their completion source when nvim-cmp is
			-- 		-- loaded, so pretend that we are nvim-cmp, and that nvim-cmp is loaded.
			-- 		-- most plugins don't do this, so this option should rarely be needed
			-- 		-- NOTE: only has effect when using lazy.nvim plugin manager
			-- 		impersonate_nvim_cmp = true,
			--
			-- 		-- some sources, like codeium.nvim, rely on nvim-cmp events to function properly
			-- 		-- when enabled, emit those events
			-- 		-- NOTE: somewhat hacky, may harm performance or break
			-- 		enable_events = true,
			--
			-- 		-- print some debug information. Might be useful for troubleshooting
			-- 		debug = true,
			-- 	},
			-- },
			-- -- {
			-- -- 	'nikutsuki/bcp.nvim',
			-- -- 	dependecies = { 'zbirenbaum/copilot.lua' },
			-- --
			-- -- 	config = function()
			-- -- 		require('bcp').setup()
			-- -- 	end,
			-- -- },
		},
		opts = {
			-- completion = {
			-- 	-- remember to enable your providers here
			-- 	enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
			-- },
			-- providers = {
			-- 	-- create provider
			-- 	copilot = {
			-- 		name = 'copilot', -- IMPORTANT: use the same name as you would for nvim-cmp
			-- 		module = 'blink.compat.source',
			--
			-- 		-- all blink.cmp source config options work as normal:
			-- 		score_offset = -3,
			--
			-- 		opts = {
			-- 			-- this table is passed directly to the proxied completion source
			-- 			-- as the `option` field in nvim-cmp's source config
			--
			-- 			-- this is an option from cmp-digraphs
			-- 			-- cache_digraphs_on_start = true,
			-- 		},
			-- 	},
			highlight = {
				use_nvim_cmp_as_default = true,
			},
			windows = {
				autocomplete = {
					draw = {
						columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
					},
					border = 'rounded',
				},
				documentation = {
					border = 'rounded',
				},
				signature_help = {
					border = 'rounded',
					scrollbar = true,
				},
			},
		},
	},
	-- LSP servers and clients communicate what features they support through "capabilities".
	--  By default, Neovim support a subset of the LSP specification.
	--  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
	--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
	--
	-- This can vary by config, but in-general for nvim-lspconfig:
	--
	-- {
	-- 	'neovim/nvim-lspconfig',
	-- 	dependencies = { 'saghen/blink.cmp' },
	-- 	config = function(_, opts)
	-- 		local lspconfig = require('lspconfig')
	-- 		for server, config in pairs(opts.servers or {}) do
	-- 			config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
	-- 			lspconfig[server].setup(config)
	-- 		end
	-- 	end,
	-- },
}
