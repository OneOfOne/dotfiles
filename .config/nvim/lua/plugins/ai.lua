return {
	{
		'Davidyz/VectorCode',
		version = '*',
		enabled = false,
		opts = {
			async_backend = 'lsp',
			exclude_this = true,
			n_query = 5,
		},
	},
	{
		'milanglacier/minuet-ai.nvim',
		-- enabled = require('config.utils').is_local(),
		enabled = false,
		opts = {
			n_completions = 3,
			context_window = 65536,

			throttle = 100,
			debounce = 250,
			request_timeout = 20,

			add_single_line_entry = true,

			before_cursor_filter_length = 2,

			provider = 'openai_compatible',
			provider_options = {
				openai_compatible = {
					name = 'Llama.cpp',
					end_point = 'http://localhost:10600/v1/chat/completions',
					api_key = 'TERM',
					-- model = 'bartowski/Spark-X2.6-4B-GGUF:Q4_K_M',
					model = 'ornith-ai/Ornith-1.5-9B-GGUF:Q5_K_M',
					-- model = 'Qwen3.8-27B-OMP',
					stream = true,
					optional = {
						provider = {
							-- Prioritize throughput for faster completion
							sort = 'throughput',
						},
						-- disable thinking to avoid first token latency
						reasoning_effort = 'none',
					},
					-- thank you gemini
					-- transform = {
					-- 	function(data)
					-- 		-- Get the text on the current line before the cursor
					-- 		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
					-- 		local line_prefix = vim.api.nvim_buf_get_text(0, row - 1, 0, row - 1, col, {})[1] or ''
					-- 		local trimmed_prefix = vim.trim(line_prefix)
					-- 		for i, text in ipairs(data) do
					-- 			-- Strip leading newlines if we are already mid-line
					-- 			if trimmed_prefix ~= '' then
					-- 				text = text:gsub('^\n+', '')
					-- 			end
					-- 			-- If the model echoed the current line's prefix, strip it
					-- 			if line_prefix ~= '' and vim.startswith(text, line_prefix) then
					-- 				text = text:sub(#line_prefix + 1)
					-- 			elseif trimmed_prefix ~= '' and vim.startswith(vim.trim(text), trimmed_prefix) then
					-- 				text = text:gsub('^%s*' .. vim.pesc(trimmed_prefix), '', 1)
					-- 			end
					-- 			data[i] = text
					-- 		end
					-- 		return data
					-- 	end,
					-- },
					-- system = {
					-- 	prompt = function()
					-- 		local ft = vim.bo.filetype ~= '' and vim.bo.filetype or 'text'
					-- 		local filename = vim.fn.expand('%:t')
					-- 		local base = require('minuet.config').default_system.prompt
					--
					-- 		local extra = string.format(
					-- 			'\nYou are currently editing a %s file named "%s". '
					-- 				.. 'Strictly follow %s syntax, indentation, and idioms. '
					-- 				.. 'Complete the code starting strictly AFTER <cursorPosition>. '
					-- 				.. 'Never wrap completions in markdown code fences. '
					-- 				.. 'Additional context from other files in the repository will be enclosed in <repo_context> tags. Each file will be separated by <file_separator> tags, '
					-- 				.. 'containing its relative path and content. ',
					--
					-- 			ft,
					-- 			filename,
					-- 			ft
					-- 		)
					-- 		return base .. extra
					-- 	end,
					-- },
					chat_input = {
						-- template = '{{{repo_context}}}\n{{{language}}}\n{{{tab}}}\n{{{context_before_cursor}}} <cursorPosition>\n{{{context_after_cursor}}}',
						template = '{{{repo_context}}}\n{{{language}}}\n{{{tab}}}\n<contextAfterCursor>{{{context_after_cursor}}}<contextBeforeCursor>{{{context_before_cursor}}}<cursorPosition>',
						repo_context = function(_, _, _)
							local has_vc, vectorcode_config = pcall(require, 'vectorcode.config')
							if not has_vc then
								return ''
							end
							local vectorcode_cacher = vectorcode_config.get_cacher_backend()
							local prompt_message = ''
							local cache_result = vectorcode_cacher.query_from_cache(0)
							for _, file in ipairs(cache_result) do
								prompt_message = prompt_message
									.. '<file_separator>'
									.. file.path
									.. '\n'
									.. file.document
							end
							-- Cap VectorCode context to ~8000 chars (~2000 tokens) so it doesn't overwhelm the 4B model
							prompt_message = vim.fn.strcharpart(prompt_message, 0, 8000)
							if prompt_message ~= '' then
								return '<repo_context>\n' .. prompt_message .. '\n</repo_context>'
							end
							return ''
						end,
					},
					-- chat_input = {
					-- 	template = '{{{repo_context}}}\n{{{language}}}\n{{{tab}}}\n<contextAfterCursor>{{{context_after_cursor}}}<contextBeforeCursor>{{{context_before_cursor}}}<cursorPosition>',
					-- 	repo_context = function(_, _, _)
					-- 		local prompt_message = ''
					-- 		if has_vc and vectorcode_cacher then
					-- 			local cache_result = vectorcode_cacher.query_from_cache(0)
					-- 			for _, file in ipairs(cache_result) do
					-- 				prompt_message = prompt_message
					-- 					.. '<file_separator>'
					-- 					.. file.path
					-- 					.. '\n'
					-- 					.. file.document
					-- 			end
					-- 		end
					--
					-- 		prompt_message = vim.fn.strcharpart(prompt_message, 0, RAG_Context_Window_Size)
					--
					-- 		if prompt_message ~= '' then
					-- 			prompt_message = '<repo_context>\n' .. prompt_message .. '\n</repo_context>'
					-- 		end
					-- 		return prompt_message
					-- 	end,
					-- 	context_before_cursor = function(_, _, _)
					-- 		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
					-- 		local lines = vim.api.nvim_buf_get_text(0, 0, 0, row - 1, col, {})
					-- 		return table.concat(lines, '\n')
					-- 	end,
					-- 	context_after_cursor = function(_, _, _)
					-- 		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
					-- 		local last_row = vim.api.nvim_buf_line_count(0) - 1
					-- 		local last_line = vim.api.nvim_buf_get_lines(0, last_row, last_row + 1, false)[1] or ''
					-- 		local lines = vim.api.nvim_buf_get_text(0, row - 1, col, last_row, #last_line, {})
					-- 		return table.concat(lines, '\n')
					-- 	end,
					-- },
				},
			},
		},
	},
	{
		'zbirenbaum/copilot.lua',
		dependencies = {
			'copilotlsp-nvim/copilot-lsp',
		},
		optional = true,
		opts = {
			suggestion = {
				max_lines = 3,
			}, -- copilot_model = 'claude-sonnet-4-20250514x',
			nes = {
				enabled = false,
				auto_trigger = false,
				keymap = {
					accept_and_goto = '<C-i>',
					accept = false,
					dismiss = '<Esc>',
				},
			},
		},
	},
}
