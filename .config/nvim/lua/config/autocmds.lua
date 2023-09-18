local group = vim.api.nvim_create_augroup('OoO', {})

local function au(typ, pattern, cmdOrFn)
	if (type(cmdOrFn) == 'function') then
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
	else
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
	end
end

-- au('FileType', 'json', [[setlocal conceallevel=0]])

au(
	{ 'BufWritePre' },
	{ '*' },
	function()
		local cur = vim.fn.getpos('.')
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos('.', cur)
	end
)
