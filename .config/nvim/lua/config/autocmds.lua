local group = vim.api.nvim_create_augroup('OoO', {})

local function au(typ, pattern, cmdOrFn)
	if type(cmdOrFn) == 'function' then
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
	else
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
	end
end

local has_inlay_hints = nil

au('ModeChanged', { '*' }, function()
	local ih = vim.lsp.inlay_hint
	local nmode = vim.v.event.new_mode

	if has_inlay_hints == nil or nmode ~= 'n' then
		has_inlay_hints = ih.is_enabled()
	end

	if nmode == 'n' and not has_inlay_hints then
		return
	end

	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, cli in ipairs(clients) do
		if cli.server_capabilities.inlayHintProvider then
			ih.enable(0, nmode == 'n')
			return
		end
	end
end)

au('InsertEnter', '*', function()
	vim.diagnostic.config({
		virtual_text = false,
	})
end)

au('InsertLeave', '*', function()
	vim.diagnostic.config({
		virtual_text = true,
	})
end)

au('FileType', { 'lazyterm', 'terminal' }, function()
	vim.wo.spell = false
	vim.wo.winfixbuf = true
end)

au('FileType', { 'json', 'jsonc', 'Outline' }, function()
	vim.wo.spell = false
	vim.wo.conceallevel = 0
end)

au('FileType', { 'notify' }, function()
	vim.wo.spell = false
	vim.bo.filetype = 'markdown'
end)

-- au('CursorMovedI', nil, function()
-- 	require('cmp').close()
-- end)
--
-- au('CursorHoldI', nil, function()
-- 	if #vim.fn.getline('.') > 1 then
-- 		require('cmp').complete()
-- 	end
-- end)
