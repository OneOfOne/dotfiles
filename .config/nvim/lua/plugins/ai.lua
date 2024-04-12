return {
	{
		'ChatGPT.nvim',
		dir = '~/code/nvim/ChatGPT.nvim',
		enabled = not os.getenv('SSH_CONNECTION'),
		event = 'VeryLazy',
		keys = {
			{ '<leader>cga', '<cmd>ChatGPTActAs<CR>', mode = { 'n', 'v' } },
			{ '<leader>cgt', '<cmd>ChatGPT<CR>', mode = { 'n', 'v' } },
			{
				'<leader>cge',
				'<cmd>ChatGPTEditWithInstruction<CR>',
				desc = 'Edit with instruction',
				mode = { 'n', 'v' },
			},
			{
				'<leader>cgg',
				'<cmd>ChatGPTRun grammar_correction<CR>',
				desc = 'Grammar Correction',
				mode = { 'n', 'v' },
			},
			{ '<c-c>', '<cmd>ChatGPTRun complete_code<CR>', desc = 'Complete', mode = { 'i' } },
			{ '<leader>cgt', '<cmd>ChatGPTRun translate<CR>', desc = 'Translate', mode = { 'n', 'v' } },
			{ '<leader>cgk', '<cmd>ChatGPTRun keywords<CR>', desc = 'Keywords', mode = { 'n', 'v' } },
			{ '<leader>cgd', '<cmd>ChatGPTRun docstring<CR>', desc = 'Docstring', mode = { 'n', 'v' } },
			{ '<leader>cga', '<cmd>ChatGPTRun add_tests<CR>', desc = 'Add Tests', mode = { 'n', 'v' } },
			{ '<leader>cgo', '<cmd>ChatGPTRun optimize_code<CR>', desc = 'Optimize Code', mode = { 'n', 'v' } },
			{ '<leader>cgs', '<cmd>ChatGPTRun summarize<CR>', desc = 'Summarize', mode = { 'n', 'v' } },
			{ '<leader>cgf', '<cmd>ChatGPTRun fix_bugs<CR>', desc = 'Fix Bugs', mode = { 'n', 'v' } },
			{ '<leader>cgx', '<cmd>ChatGPTRun explain_code<CR>', desc = 'Explain Code', mode = { 'n', 'v' } },
			{ '<leader>cgr', '<cmd>ChatGPTRun roxygen_edit<CR>', desc = 'Roxygen Edit', mode = { 'n', 'v' } },
			{
				'<leader>cgl',
				'<cmd>ChatGPTRun code_readability_analysis<CR>',
				desc = 'Code Readability Analysis',
				mode = { 'n', 'v' },
			},
		},
		config = function()
			require('chatgpt').setup({
				api_host_cmd = 'echo http://localhost:11434',
				api_key_cmd = "echo ''",
				openai_params = {
					model = 'codegemma:7b-instruct',
					frequency_penalty = 0,
					presence_penalty = 0,
					temperature = 0.7,
					top_p = 1,
					n = 1,
				},
				openai_edit_params = {
					model = 'codegemma:7b-instruct',
					frequency_penalty = 0,
					presence_penalty = 0,
					temperature = 0.7,
					top_p = 1,
					n = 1,
				},
			})
		end,
		dependencies = {
			'MunifTanjim/nui.nvim',
			'nvim-lua/plenary.nvim',
			'folke/trouble.nvim',
			'nvim-telescope/telescope.nvim',
		},
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		branch = 'canary',
		enabled = not os.getenv('SSH_CONNECTION'),
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
		},
		keys = {
			{
				'<leader>ah',
				function()
					local actions = require('CopilotChat.actions')
					require('CopilotChat.integrations.telescope').pick(actions.help_actions())
				end,
				desc = 'CopilotChat - Help actions',
			},
			-- Show
			{
				'<leader>ap',
				function()
					local actions = require('CopilotChat.actions')
					require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
				end,
				desc = 'CopilotChat - Prompt actions',
			},
			{
				'<leader>ac',
				function()
					local input = vim.fn.input('Quick Chat: ')
					if input ~= '' then
						require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
					end
				end,
				desc = 'CopilotChat - Quick chat',
			},
			{ '<leader>ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
			{ '<leader>at', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
			{ '<leader>ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
			{ '<leader>aR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
			{ '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
			{
				'<leader>am',
				'<cmd>CopilotChatCommit<cr>',
				desc = 'CopilotChat - Generate commit message for all changes',
			},
			{
				'<leader>aM',
				'<cmd>CopilotChatCommitStaged<cr>',
				desc = 'CopilotChat - Generate commit message for staged changes',
			},
			{ '<leader>af', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
			{ '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
		},
		opts = {
			window = {
				layout = 'float',
				relative = 'cursor',
				width = 0.5,
				height = 0.4,
				row = 1,
			},
			show_help = true,
			debug = false,
		},
		config = function(_, opts)
			local chat = require('CopilotChat')
			local select = require('CopilotChat.select')
			opts.selection = select.unnamed
			chat.setup(opts)

			vim.api.nvim_create_autocmd('BufEnter', {
				pattern = 'copilot-*',
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = true

					local ft = vim.bo.filetype
					if ft == 'copilot-chat' then
						vim.bo.filetype = 'markdown'
					end
				end,
			})
		end,
	},
}
