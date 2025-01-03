return {
	{
		'milanglacier/minuet-ai.nvim',
		lazy = false,
		enabled = false,
		config = function()
			require('minuet').setup({
				after_cursor_filter_length = 20,
				notify = 'error',
				provider = 'openai',
				provider_options = {
					openai_fim_compatible = {
						model = 'qwen2.5-coder:7b',
						end_point = 'http://127.0.0.1:11434/v1/completions',
						name = 'Ollama',
						stream = true,
						api_key = 'LANG',
						max_tokens = 512,
						optional = {
							stop = nil,
							max_tokens = nil,
						},
					},
				},
			})
		end,
	},
	-- {
	-- 	'nvim-cmp',
	-- 	opts = function(_, opts)
	-- 		-- if you wish to use autocomplete
	-- 		table.insert(opts.sources, 1, {
	-- 			name = 'minuet',
	-- 			group_index = 1,
	-- 			priority = 100,
	-- 		})
	--
	-- 		opts.performance = {
	-- 			-- It is recommended to increase the timeout duration due to
	-- 			-- the typically slower response speed of LLMs compared to
	-- 			-- other completion sources. This is not needed when you only
	-- 			-- need manual completion.
	-- 			fetching_timeout = 2000,
	-- 		}
	--
	-- 		opts.mapping = vim.tbl_deep_extend('force', opts.mapping or {}, {
	-- 			-- if you wish to use manual complete
	-- 			['<c-y>'] = require('minuet').make_cmp_map(),
	-- 			-- You don't need to worry about <CR> delay because lazyvim handles this situation for you.
	-- 			['<CR>'] = nil,
	-- 		})
	-- 	end,
	-- },
}
