return {
	{ 'sindrets/diffview.nvim' },
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
				window = {
					mappings = {
						['<leader>o'] = 'system_open',
						['<leader>d'] = 'show_diff',
						['<leader>h'] = 'show_history',
					},
				},
			},
			commands = {
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					-- macOs: open file in default application in the background.
					-- vim.fn.jobstart({ 'xdg-open', '-g', path }, { detach = true })
					-- Linux: open file in default application
					vim.fn.jobstart({ 'xdg-open', path }, { detach = true })
				end,
				show_diff = function(state)
					-- some variables. use any if you want
					local node = state.tree:get_node()
					local is_file = node.type == 'file'
					if not is_file then
						vim.notify('Diff only for files', vim.log.levels.ERROR)
						return
					end
					-- open file
					local cc = require('neo-tree.sources.common.commands')
					cc.open(state, function()
						-- do nothing for dirs
					end)

					vim.cmd([[DiffviewOpen HEAD^ -- %]])
				end,
				show_history = function(state)
					-- some variables. use any if you want
					local node = state.tree:get_node()
					local is_file = node.type == 'file'
					if not is_file then
						vim.notify('Diff only for files', vim.log.levels.ERROR)
						return
					end
					-- open file
					local cc = require('neo-tree.sources.common.commands')
					cc.open(state, function()
						-- do nothing for dirs
					end)

					vim.cmd([[DiffviewFileHistory %]])
				end,
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
