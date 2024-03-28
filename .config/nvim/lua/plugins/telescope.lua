return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
				config = function()
					require('telescope').load_extension('fzf')
				end,
			},
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
					'package.json',
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
					ignore_current_buffer = true,
					previewer = false,
					theme = 'dropdown',
				},
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = function()
						return { '--hidden' }
					end,
				},
			},
		},
	},
}
