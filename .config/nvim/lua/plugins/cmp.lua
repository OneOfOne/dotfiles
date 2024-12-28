return {
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
			{ 'iguanacucumber/mag-nvim-lsp', name = 'cmp-nvim-lsp', opts = {} },
			{ 'iguanacucumber/mag-buffer', name = 'cmp-buffer' },
			{ 'iguanacucumber/mag-cmdline', name = 'cmp-cmdline' },
			{ 'https://codeberg.org/FelipeLema/cmp-async-path', name = 'cmp-path' },
		},

		opts = function(_, opts)
			local cmp = require('cmp')
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
		opts = {
			appearance = {
				use_nvim_cmp_as_default = true,
			},
			completion = {
				menu = {
					winblend = 0,
					draw = {
						columns = {
							{ 'label', 'label_description', gap = 1 },
							{ 'kind_icon', 'source_name', gab = 1 },
						},
						padding = 0,
					},
					border = 'rounded',
				},
				documentation = {
					window = {
						border = 'rounded',
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					border = 'rounded',
					scrollbar = true,
				},
			},
			fuzzy = {
				use_typo_resistance = false,
			},
		},
	},
	-- {
	-- 	'neovim/nvim-lspconfig',
	-- 	dependencies = { 'saghen/blink.cmp' },
	--
	-- 	-- example using `opts` for defining servers
	-- 	opts = {
	-- 		servers = {
	-- 			lua_ls = {},
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		for _, config in pairs(opts.servers) do
	-- 			config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
	-- 		end
	-- 	end,
	-- },
}
