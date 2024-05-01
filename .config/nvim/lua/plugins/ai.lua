return {
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		branch = 'canary',
		enabled = require('config.utils').is_local(),
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
