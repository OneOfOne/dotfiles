local initial_close = false
return {
	{
		'nvim-neo-tree/neo-tree.nvim',
		opts = {
			sources = { 'filesystem' },
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
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
			},
			event_handlers = {
				-- {
				-- 	event = 'neo_tree_buffer_leave',
				-- 	handler = function()
				-- 		require('neo-tree.command').execute({ action = 'close' })
				-- 		initial_close = true
				-- 	end,
				-- },
				-- {
				-- 	event = 'neo_tree_buffer_enter',
				-- 	handler = function()
				-- 		if initial_close then
				-- 			return
				-- 		end
				-- 		require('neo-tree.command').execute({ action = 'close' })
				-- 		initial_close = true
				-- 	end,
				-- },
			},
		},
	},
}
