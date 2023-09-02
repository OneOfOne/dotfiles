local function au(type, opts)
	vim.api.nvim_create_autocmd(type, opts);
end
au("FileType", { pattern = "json", command = [[setlocal conceallevel=0]] })
