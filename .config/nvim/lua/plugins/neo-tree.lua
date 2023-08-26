return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
		filesystem = {
			filtered_items = {
				hide_gitignored = true,
				hide_by_name = {
					'.git',
					'.DS_Store',
					'thumbs.db',
					'node_modules'
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
			},
		},
		use_libuv_file_watcher = true,
	},
}
