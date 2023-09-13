return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				config = function()
					require('telescope').load_extension('fzf')
				end,
			},
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						['<esc>'] = require('telescope.actions').close,
					},
				},
			},
			pickers = {
				buffers = {
					sort_lastused = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = 'smart_case',
				},
			},
		},
	},
}
