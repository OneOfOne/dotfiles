return {
	{
		'https://gitlab.com/bartekjaszczak/finale-nvim',
		config = function() end,
	},
	{
		'Shatur/neovim-ayu',
		priority = 1000,
		config = function()
			local colors = require('ayu.colors')
			colors.generate(false)
			require('ayu').setup({
				mirage = false,
				overrides = function()
					return {
						Normal = { bg = '#181111' },
						LineNr = { fg = '#7F6633' }, -- 50% luminance of #FFCC66 used in colors.accent
						Visual = { bg = '#533a3a' },
						BlinkCmpGhostText = { fg = colors.accent },
						LspInlayHint = { fg = colors.comment, bg = colors.bg, italic = true },
						Pmenu = { bg = colors.bg },
						PmenuSel = { fg = '#7F6633' },
					}
				end,
			})
		end,
	},
	{
		'LazyVim/LazyVim',
		opts = {
			colorscheme = 'ayu',
		},
	},
	{
		'akinsho/bufferline.nvim',
		-- enabled = false,
		opts = {
			options = {
				always_show_bufferline = true,
				themable = true,
				separator_style = 'slope',
				left_mouse_command = function(bufnum)
					vim.fn.win_gotoid(vim.g.main_win or 1000) -- assume 1000 is the main window if vim.g.main_win is nil
					vim.api.nvim_set_current_buf(bufnum)
				end,
			},
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				theme = 'finale',
			},
			sections = {
				lualine_y = {
					{ 'searchcount', padding = { left = 1, right = 0 }, separator = ' ' },
					{ 'selectioncount', padding = { left = 1, right = 0 }, separator = ' ' },
					{ 'location', padding = { left = 0, right = 1 } },
				},
			},
			winbar = {
				-- lualine_a = { 'buffers' },
				-- 	lualine_b = {},
				-- 	lualine_c = {},
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = { 'tabs' },
			},
		},
	},
	{
		'folke/noice.nvim',
		-- enabled = false,
		opts = {
			presets = {
				lsp_doc_border = true,
			},
			lsp = {
				hover = { enabled = true },
				signature = { enabled = true },
			},
			smart_move = { enabled = true },
			routes = {
				{ filter = { event = 'msg_show', find = 'written' } },
				{ filter = { event = 'msg_show', find = 'yanked' } },
				{ filter = { event = 'msg_show', find = '%d+L, %d+B' } },
				{ filter = { event = 'msg_show', find = '; after #%d+' } },
				{ filter = { event = 'msg_show', find = '; before #%d+' } },
				{ filter = { event = 'msg_show', find = '%d fewer lines' } },
				{ filter = { event = 'msg_show', find = '%d more lines' } },
				{ filter = { event = 'msg_show', find = '<ed' } },
				{ filter = { event = 'msg_show', find = '>ed' } },
				{
					filter = {
						event = 'notify',
						any = {
							{ find = 'textDocument/codeLens is not supported' },
							{ find = 'Searching in Files' },
						},
					},
				},
			},
		},
	},
	{
		'folke/snacks.nvim',
		opts = {
			statuscolumn = {
				folds = {
					open = true, -- show open fold icons
					git_hl = true, -- use Git Signs hl for fold icons
				},
			},
			indent = {
				enabled = true,
				hl = {
					'SnacksIndent1',
					'SnacksIndent2',
					'SnacksIndent3',
					'SnacksIndent4',
					'SnacksIndent5',
					'SnacksIndent6',
					'SnacksIndent7',
					'SnacksIndent8',
				},
				chunk = {
					enabled = true,
				},
				blank = {
					char = ' ',
				},
			},
			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
		},
	},
}
