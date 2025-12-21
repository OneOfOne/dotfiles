return {
	{ 'xzbdmw/colorful-menu.nvim', opts = {} },
	{
		'saghen/blink.cmp',
		optional = true,
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			appearance = {
				nerd_font_variant = 'normal',
			},
			completion = {
				menu = {
					draw = {
						treesitter = { 'lsp' },
						padding = 1,
						columns = {
							{ 'kind_icon' },
							{ 'label' },
							{ 'source_name' },
						},
						components = {
							label = {
								width = { fill = true, max = 60 },
								text = function(ctx)
									local highlights_info = require('colorful-menu').blink_highlights(ctx)
									if highlights_info ~= nil then
										-- Or you want to add more item to label
										return highlights_info.label
									else
										return ctx.label
									end
								end,
								highlight = function(ctx)
									local highlights = {}
									local highlights_info = require('colorful-menu').blink_highlights(ctx)
									if highlights_info ~= nil then
										highlights = highlights_info.highlights
									end
									for _, idx in ipairs(ctx.label_matched_indices) do
										table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
									end
									return highlights
								end,
							},
						},
					},
				},
				list = {
					selection = { preselect = false, auto_insert = false },
					cycle = {
						-- from_top = false,
					},
				},
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
				trigger = { prefetch_on_insert = false },
			},
			signature = {
				enabled = true,
				window = {
					scrollbar = true,
				},
			},
			cmdline = {
				keymap = { preset = 'inherit' },
			},
			fuzzy = {},
			sources = {},
		},
	},
}
