local group = vim.api.nvim_create_augroup('OoO', {})

local function au(typ, pattern, cmdOrFn)
	if type(cmdOrFn) == 'function' then
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
	else
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
	end
end

au('FileType', { 'json', 'jsonc', 'Outline' }, function()
	vim.wo.spell = false
	vim.wo.conceallevel = 0
end)

au('LspAttach', nil, function()
	vim.cmd([[match ErrorMsg '\s\+$']])
end)

au({ 'CursorHold', 'InsertLeave' }, nil, function()
	local opts = {
		focusable = false,
		scope = 'cursor',

		close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
	}
	vim.diagnostic.open_float(nil, opts)
end)

au('InsertEnter', nil, function()
	vim.diagnostic.enable(false)
end)

au('InsertLeave', nil, function()
	vim.diagnostic.enable(true)
end)
