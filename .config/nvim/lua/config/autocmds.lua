local function au(type, pattern, command)
	vim.api.nvim_create_autocmd(type, { pattern = pattern, command = command });
end
au('FileType', 'json', [[setlocal conceallevel=0]])
-- au('BufWritePre', '*', [[<cmd>%s/\s/+$//e<cr>]])
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = {"*"},
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})
