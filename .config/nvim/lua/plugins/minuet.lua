# thanks to https://git.hendrikpeter.net/hendrikpeter/peva-nvim-lazy/-/blob/main/lua/plugins/minuet.lua?ref_type=heads

vim.api.nvim_create_user_command('MinuetPinContext', function(args)
	local file = args.args ~= '' and args.args or vim.api.nvim_buf_get_name(0)

	if file == '' then
		vim.notify('MinuetPinContext: no file path and buffer has no name', vim.log.levels.ERROR)
		return
	end

	-- check if file is readable
	if not vim.uv.fs_access(file, 'r') then
		vim.notify('MinuetPinContext: file not readable: ' .. file, vim.log.levels.ERROR)
		return
	end

	vim.b.minuet_pin_context = {
		name = file,
		content = table.concat(vim.fn.readfile(file), '\n'),
	}

	vim.notify('MinuetPinContext: pinned ' .. file, vim.log.levels.INFO)
end, {
	nargs = '?',
	complete = 'file',
})

local minuet_fim_prefix_function = function(context_before_cursor, _, _)
	local pin_context = ''

	if vim.b.minuet_pin_context then
		pin_context = vim.b.minuet_pin_context.content
	end

	-- check if pin_context contains non-whitespace
	if pin_context:match('%S') then
		pin_context = '<repo_context><filename>'
			.. vim.b.minuet_pin_context.name
			.. '</filename>'
			.. pin_context
			.. '\n</repo_context>\n\n# Context before cursor in current buffer begins\n'
	end

	return pin_context .. context_before_cursor
end

return {
	'milanglacier/minuet-ai.nvim',
	event = 'InsertEnter',
	opts = {
			notify = 'error',
			n_completions = 3,
			context_window = 4096,
			provider = 'openai_fim_compatible',
			request_timeout = 15,
			provider_options = {
				openai_fim_compatible = {
					api_key = 'TERM',
					name = 'LLama.cpp',
					end_point = 'http://localhost:10600/v1/completions',
					template = {
						prompt = minuet_fim_prefix_function,
					},
					optional = {
						max_tokens = 2048,
						stop = { '\n\n' },
					},
				},
			},
		}
}
