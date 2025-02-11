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

au('FileType', { 'notify' }, function()
	vim.bo.filetype = 'markdown'
	vim.wo.spell = false
end)

au({ 'TermOpen', 'TermEnter' }, 'term://*', function()
	vim.wo.winfixbuf = true
end)

au('LspAttach', nil, function()
	vim.cmd([[match ErrorMsg '\s\+$']])
end)

au('WinScrolled', nil, function()
	-- local cursor = vim.api.nvim_win_get_cursor(0)
	-- vim.notify(vim.inspect(cursor), 'debug')
	-- vim.notify(vim.fn.strftime('%s'))
end)
