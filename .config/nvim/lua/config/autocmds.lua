local function au(type, pattern, command)
	vim.api.nvim_create_autocmd(type, { pattern = pattern, command = command })
end

-- au('FileType', 'json', [[setlocal conceallevel=0]])

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*' },
	callback = function()
		local cur = vim.fn.getpos('.')
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos('.', cur)
	end,
})
