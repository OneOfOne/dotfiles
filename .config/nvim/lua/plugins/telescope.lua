local root = require('lazyvim.util.root')
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
			{ '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'Find Files (Root Dir)' },
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						['<esc>'] = require('telescope.actions').close,
					},
				},
				file_ignore_patterns = {
					'node_modules',
					'.env',
					'yarn.lock',
					'target',
					'build',
					'dist',
					'.git',
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
					cwd = root.git() or root.get(),
					hidden = true,
				},
				live_grep = {
					additional_args = function()
						return { '--hidden', '--mmap', '-g', '!{**/node_modules/*,**/.git/*}' }
					end,
				},
			},
		},
	},
}
