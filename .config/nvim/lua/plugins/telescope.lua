return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			-- {
			-- 	'nvim-telescope/telescope-fzf-native.nvim',
			-- 	build = 'make',
			-- 	config = function()
			-- 		require('telescope').load_extension('fzf')
			-- 	end,
			-- },
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
				},
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end
				},
			},
			-- extensions = {
			-- 	fzf = {
			-- 		fuzzy = true,
			-- 		override_generic_sorter = true,
			-- 		override_file_sorter = true,
			-- 		case_mode = 'smart_case',
			-- 	},
			-- },
		},
	},
}
