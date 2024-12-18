local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local root = require('lazyvim.util.root')
local utils = require('telescope.utils')

return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{
				'isak102/telescope-git-file-history.nvim',
				dependencies = { 'tpope/vim-fugitive' },
				event = 'VeryLazy',
				config = function()
					LazyVim.on_load('telescope.nvim', function()
						require('telescope').load_extension('git_file_history')
					end)
				end,
				keys = {
					{
						'<leader>gf',
						function()
							require('telescope').extensions.git_file_history.git_file_history()
						end,
						desc = 'git current file history',
					},
				},
			},
		},
		keys = {
			{
				'<leader><space>',
				function()
					builtin.find_files({ cwd = root.git() or root.get() })
				end,
				desc = 'Find Files (Root Dir)',
			},
			{
				'<leader>/',
				function()
					builtin.live_grep({ cwd = root.git() or root.get() })
				end,
				desc = 'Grep Files (Root Dir)',
			},
			{
				'<leader>b<space>',
				function()
					builtin.find_files({ cwd = utils.buffer_dir(), hidden = false })
				end,
				desc = 'Find files in cwd',
			},
			{
				'<leader>b/',
				function()
					builtin.live_grep({ cwd = utils.buffer_dir() })
				end,
				desc = 'Grep files in cwd',
			},
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						-- ['<esc>'] = actions.close,
						['<C-q>'] = function(bufnr)
							actions.smart_send_to_qflist(bufnr)
							actions.open_qflist(bufnr)
							require('config.utils').gsr()
						end,
					},
				},
			},
			pickers = {
				buffers = {
					sort_lastused = true,
					sort_mru = true,
					ignore_current_buffer = true,
					previewer = false,
					theme = 'dropdown',
				},
				find_files = {
					file_ignore_patterns = { 'node_modules', '.git', '.venv', 'build', 'dist' },
					hidden = true,
				},
				live_grep = {
					file_ignore_patterns = { 'node_modules', '.git', '.venv', 'build', 'dist' },
					additional_args = function()
						return { '--hidden', '--mmap' }
					end,
				},
			},
		},
	},
}
