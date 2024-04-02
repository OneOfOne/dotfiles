return {
	{
		'nvim-neo-tree/neo-tree.nvim',
		opts = {
			sort_case_insensitive = true,
			enable_cursor_hijack = true,
			auto_clean_after_session_restore = true,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						'.git',
						'.DS_Store',
						'thumbs.db',
						'node_modules',
					},
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
				},
			},
		},
	},
}
