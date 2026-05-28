# thanks to https://git.hendrikpeter.net/hendrikpeter/peva-nvim-lazy/-/blob/main/lua/plugins/minuet.lua?ref_type=heads
local minuet_fim_prefix_function = function(context_before_cursor, _, _)
	local file = vim.api.nvim_buf_get_name(0)
	local file_contents = ''
	local pin_context = ''

	if vim.uv.fs_access(file, 'r') then
		-- file_contents = table.concat(vim.fn.readfile(file), '\n')
	end

	-- check if pin_context contains non-whitespace
	if file_contents:match('%S') then
		pin_context = '<repo_context><filename>'
			.. file
			.. '</filename>'
			.. file_contents
			.. '\n</repo_context>\n\n# Context before cursor in current buffer begins\n'
	end

	return pin_context .. context_before_cursor
end

return {
	'milanglacier/minuet-ai.nvim',
	enabled = false,
	event = 'InsertEnter',
	opts = {
			notify = 'error',
			n_completions = 3,
			context_window = 16 * 1024,
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
						max_tokens = 8 * 1024,
						stop = { '\n\n' },
					},
				},
			},
		}
}
