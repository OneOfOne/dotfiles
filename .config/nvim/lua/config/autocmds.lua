local function au(type, pattern, command)
	vim.api.nvim_create_autocmd(type, { pattern = pattern, command = command });
end
au("FileType", "json", [[setlocal conceallevel=0]])
au("BufWritePre", "*", [[:%s\v\s+$//e]])
