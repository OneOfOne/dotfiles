vim.g.coq_settings = { auto_start = 'shut-up' }
return {
	{
		'hrsh7th/nvim-cmp',
		-- enabled = false,
	},
	{
		'ms-jpq/coq_nvim',
		branch = 'coq',
		enabled = false,
		event = 'InsertEnter',
		config = function()
			local coq = require('coq')
			coq.Now() -- Start coq

			-- 3party sources
			require('coq_3p')({
				{ src = 'copilot', short_name = 'COP', accept_key = '<c-f>' },
				{ src = 'codeium', short_name = 'COD' },
			})
		end,
		dependencies = {
			{ 'ms-jpq/coq.artifacts', branch = 'artifacts' },
			{ 'ms-jpq/coq.thirdparty', branch = '3p', module = 'coq_3p' },
		},
	},
}
