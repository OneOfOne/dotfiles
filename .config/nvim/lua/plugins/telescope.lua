local telescope = require('telescope')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local conf = require('telescope.config')
local utils = require('utils')
local m = utils.map

local dropdown = require('telescope.themes').get_dropdown();
telescope.setup{
	defaults = {
		-- prompt_prefix = "λ -> ",
		-- selection_caret = "|> ",
		theme = "dropdown",
		previewer = false,
		-- Don't pass to normal mode with ESC, problem with telescope-project
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		file_browser = {
			theme = "dropdown",
			previewer = false
		},
		find_files = {
			theme = "dropdown",
			previewer = false
		},
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			theme = "dropdown",
			previewer = false,
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer,
					-- or right hand side can also be the name of the action as string
					["<c-d>"] = "delete_buffer",
				},
				n = {
					["<c-d>"] = actions.delete_buffer,
				}
			}
		}
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	}
}

-- Extensions

-- telescope.load_extension('octo')
--telescope.load_extension('fzy_native')
-- telescope.load_extension('ultisnips')
-- telescope.load_extension('project')
-- telescope.load_extension('lsp_handlers')
telescope.load_extension('coc')

-- Implement delta as previewer for diffs


local M = {}

local delta = previewers.new_termopen_previewer {
	get_command = function(entry)
		-- this is for status
		-- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
		-- just do an if and return a different command
		if entry.status == '??' or 'A ' then
			return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value }
		end

		-- note we can't use pipes
		-- this command is for git_commits and git_bcommits
		return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!' }

	end
}

M.my_git_commits = function(opts)
	opts = opts or {}
	opts.previewer = delta

	builtin.git_commits(opts)
end

M.my_git_bcommits = function(opts)
	opts = opts or {}
	opts.previewer = delta

	builtin.git_bcommits(opts)
end

M.my_git_status = function(opts)
	opts = opts or {}
	opts.previewer = delta

	builtin.git_status(opts)
end

M.project_files = function()
	local opts = {} -- define here if you want to define something
	local ok = pcall(builtin.git_files, opts)
	if not ok then builtin.find_files(opts) end
end

return M
