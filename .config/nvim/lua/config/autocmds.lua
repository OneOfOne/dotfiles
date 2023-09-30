local group = vim.api.nvim_create_augroup('OoO', {})

local function au(typ, pattern, cmdOrFn)
	if type(cmdOrFn) == 'function' then
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
	else
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
	end
end

au({ 'FileType' }, { 'json', 'jsonc', 'Outline' }, function()
	vim.wo.spell = false
	vim.wo.conceallevel = 0
end)

au({ 'FileType' }, { 'typescript', 'typescriptreact' }, function()
	vim.g.editorconfig = false
	vim.opt_local.tabstop = 3
	vim.opt_local.shiftwidth = 3
end)

-- au({ 'BufWinEnter', 'WinEnter' }, 'term://*', 'norm! i')
au({ 'BufWritePre' }, { '*' }, function()
	local cur = vim.fn.getpos('.')
	vim.cmd([[%s/\s\+$//e]])
	vim.fn.setpos('.', cur)
end)
