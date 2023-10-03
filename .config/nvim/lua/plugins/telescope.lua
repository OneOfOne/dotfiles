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
		},
		opts = {
			defaults = {
				file_ignore_patterns = { 'node_modules', '.git' },
				mappings = {
					i = {
						['<esc>'] = require('telescope.actions').close,
					},
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
