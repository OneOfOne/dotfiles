-- local float = { focusable = true, style = 'minimal', border = 'rounded', }
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float)
-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

return {
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = 'hard'
			vim.g.gruvbox_material_foreground = 'mix'
			vim.g.gruvbox_material_statusline_style = 'mix'
			vim.g.gruvbox_material_disable_italic_comment = 1
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_diagnostic_text_highlight = 1
			vim.g.gruvbox_material_diagnostic_line_highlight = 1
			vim.g.gruvbox_material_ui_contrast = 'high'
			vim.g.gruvbox_material_transparent_background = 0
			-- vim.cmd 'colorscheme gruvbox-material'
		end,
	},
	{
		'LazyVim/LazyVim',
		opts = {
			colorscheme = 'gruvbox-material',
		},
	},
	{
		'akinsho/bufferline.nvim',
		opts = {
			options = {
				always_show_bufferline = true,
				themable = true,
				separator_style = 'slope',
			},
		}
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			sections = {
				lualine_y = {
					{ 'searchcount',    separator = ' ',                  padding = { left = 1, right = 0 } },
					{ 'selectioncount', separator = ' ',                  padding = { left = 1, right = 0 } },
					{ 'location',       padding = { left = 0, right = 1 } },
				},
			}
		}
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		branch = 'v3',
		opts = function(_, opts)
			local hooks = require('ibl.hooks')
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
			end)
			opts.scope = {
				enabled = true,
				char = '│',
				show_start = false,
				highlight = { 'RainbowOrange' }
			}
			opts.indent = { highlight = { 'NeoTreeIndentMarker' } }
		end,
		config = function(_, opts)
			local hooks = require('ibl.hooks')
			require('ibl').setup(opts)
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	}

}
