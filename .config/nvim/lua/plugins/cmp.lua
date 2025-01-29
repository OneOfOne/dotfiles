return {
	{
		'giuxtaposition/blink-cmp-copilot',
		enabled = false,
	},
	{
		'saghen/blink.cmp',
		optional = true,
		opts_extend = {
			'sources.default',
		},
		dependencies = { 'fang2hou/blink-copilot' },
		opts = {
			appearance = {
				use_nvim_cmp_as_default = true,
			},
			completion = {
				accept = { auto_brackets = { enabled = true } },
				menu = {
					draw = {
						padding = 1,
						treesitter = { 'lsp' },
						columns = {
							{ 'kind_icon' },
							{ 'label', 'label_description', gap = 1 },
							{ 'source_name' },
						},
					},
					border = 'rounded',
				},
				documentation = {
					window = {
						border = 'rounded',
					},
				},
				list = {
					selection = { preselect = false, auto_insert = false },
					cycle = {
						from_top = false,
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
			fuzzy = {},
			sources = {
				-- default = { 'lsp', 'path', 'buffer', 'minuet' },
				default = { 'lsp', 'path', 'buffer' },
				transform_items = function(_, items)
					local types = require('blink.cmp.types')
					return vim.tbl_filter(function(item)
						return item.kind ~= types.CompletionItemKind.Snippet
					end, items)
				end,
				providers = {
					copilot = {
						module = 'blink-copilot',
						opts = {
							max_completions = 3,
							max_attempts = 4,
						},
					},
					-- minuet = {
					-- 	name = 'minuet',
					-- 	module = 'minuet.blink',
					-- 	score_offset = 8, -- Gives minuet higher priority among suggestions
					-- },
				},
			},
		},
	},
}
