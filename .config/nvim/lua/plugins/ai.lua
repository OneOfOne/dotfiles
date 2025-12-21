local prefill_edit_window = function(request)
	require('avante.api').edit()
	local code_bufnr = vim.api.nvim_get_current_buf()
	local code_winid = vim.api.nvim_get_current_win()
	if code_bufnr == nil or code_winid == nil then
		return
	end
	vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
	-- Optionally set the cursor position to the end of the input
	vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
	-- Simulate Ctrl+S keypress to submit
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-s>', true, true, true), 'v', true)
end

local avante_optimize_code = 'Optimize the following code'
local avante_complete_code = 'Complete the following codes written in ' .. vim.bo.filetype
local avante_add_doc = 'Document the following code'
local avante_fix_bugs = 'Fix the bugs inside the following codes if any'
local avante_add_tests = 'Implement tests for the following code'

require('which-key').add({
	{ '<leader>a', group = 'Avante' }, -- NOTE: add for avante.nvim
	{
		mode = { 'v' },
		{
			'<leader>ao',
			function()
				prefill_edit_window(avante_optimize_code)
			end,
			desc = 'Optimize Code(edit)',
		},
		{
			'<leader>ac',
			function()
				prefill_edit_window(avante_complete_code)
			end,
			desc = 'Complete Code(edit)',
		},
		{
			'<leader>ad',
			function()
				prefill_edit_window(avante_add_doc)
			end,
			desc = 'Docstring(edit)',
		},
		{
			'<leader>ab',
			function()
				prefill_edit_window(avante_fix_bugs)
			end,
			desc = 'Fix Bugs(edit)',
		},
		{
			'<leader>at',
			function()
				prefill_edit_window(avante_add_tests)
			end,
			desc = 'Add Tests(edit)',
		},
	},
})

return {
	{
		'zbirenbaum/copilot.lua',
		dependencies = {
			'copilotlsp-nvim/copilot-lsp',
		},
		optional = true,
		opts = {
			copilot_model = 'claude-sonnet-4-20250514',
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
	{
		'yetone/avante.nvim',
		event = 'InsertEnter',
		optional = true,
		opts = {
			provider = 'copilot',
			-- hints = { enabled = false },
			providers = {
				claude = {
					endpoint = 'https://api.anthropic.com',
					model = 'claude-sonnet-4-20250514',
					timeout = 60000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
					api_key_name = 'cmd:kv-get get claude',
				},
			},
			behaviour = {
				auto_suggestions = true,
				auto_add_current_file = false,
				auto_set_keymaps = true,
				confirmation_ui_style = 'popup',
			},
			selection = {
				hint_display = 'delayed',
			},
			prompt_logger = {
				enabled = false,
			},
		},
	},
}
