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

au({ 'ModeChanged' }, { '*' }, function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, cli in ipairs(clients) do
		if cli.server_capabilities.inlayHintProvider then
			LazyVim.toggle.inlay_hints(0, vim.v.event.new_mode == 'n')
			return
		end
	end
end)

--
-- au({ 'CursorHold', 'CursorHoldI' }, {}, 'TSEnable highlight')
-- au({ 'CursorMoved', 'CursorMovedI' }, {}, 'TSDisable highlight')

-- au({ 'FileType' }, { 'typescript', 'typescriptreact' }, function()
-- 	vim.g.editorconfig = false
-- 	vim.opt_local.tabstop = 3
-- 	vim.opt_local.shiftwidth = 3
-- end)

au({ 'FileType' }, { 'lazyterm', 'terminal' }, function()
	vim.wo.spell = false
	vim.wo.winfixbuf = true
end)

-- au({ 'BufWritePre' }, { '*' }, function()
-- 	local cur = vim.fn.getpos('.')
-- 	vim.cmd([[%s/\s\+$//e]])
-- 	vim.fn.setpos('.', cur)
-- end)
