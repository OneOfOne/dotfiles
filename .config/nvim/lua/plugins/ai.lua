return {
	{
		'bdcaf/gen.nvim',
		opts = {
			model = 'llama3:8b-instruct-fp16', -- The default model to use.
			host = 'localhost', -- The host running the Ollama service.
			port = '11434', -- The port on which the Ollama service is listening.
			quit_map = 'q', -- set keymap for close the response window
			retry_map = '<c-r>', -- set keymap to re-send the current prompt
			init = function(options)
				-- pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
			end,
			-- Function to initialize Ollama
			command = function(options)
				local body = { model = options.model, stream = true }
				return 'curl --silent --no-buffer -X POST http://'
					.. options.host
					.. ':'
					.. options.port
					.. '/api/chat -d $body'
			end,
			-- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
			-- This can also be a command string.
			-- The executed command must return a JSON object with { response, context }
			-- (context property is optional).
			-- list_models = '<omitted lua function>', -- Retrieves a list of model names
			display_mode = 'float', -- The display mode. Can be "float" or "split".
			show_prompt = true, -- Shows the prompt submitted to Ollama.
			show_model = true, -- Displays which model you are using at the beginning of your chat session.
			no_auto_close = true, -- Never closes the window automatically.
			debug = true, -- Prints errors and the command which is run.
		},
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		branch = 'canary',
		enabled = require('config.utils').is_local(),
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
		},
		event = 'BufEnter',
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
				'<leader>ap',
				function()
					local actions = require('CopilotChat.actions')
					require('CopilotChat.integrations.telescope').pick(
						actions.prompt_actions({ selection = require('CopilotChat.select').visual })
					)
				end,
				mode = 'v',
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
			mappings = {
				-- Use tab for completion
				complete = {
					detail = 'Use @<Tab> or /<Tab> for options.',
					insert = '<Tab>',
				},
				-- Close the chat
				close = {
					normal = 'q',
					insert = '<C-c>',
				},
				-- Reset the chat buffer
				reset = {
					normal = '<C-l>',
					insert = '<C-l>',
				},
				-- Submit the prompt to Copilot
				submit_prompt = {
					normal = '<CR>',
					insert = '<C-CR>',
				},
				-- Accept the diff
				accept_diff = {
					normal = '<C-y>',
					insert = '<C-y>',
				},
				-- Yank the diff in the response to register
				yank_diff = {
					normal = 'gmy',
				},
				-- Show the diff
				show_diff = {
					normal = 'gmd',
				},
				-- Show the prompt
				show_system_prompt = {
					normal = 'gmp',
				},
				-- Show the user selection
				show_user_selection = {
					normal = 'gms',
				},
			},
		},
		config = function(_, opts)
			local chat = require('CopilotChat')
			local select = require('CopilotChat.select')
			opts.selection = select.unnamed
			chat.setup(opts)

			vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = '*', range = true })

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
