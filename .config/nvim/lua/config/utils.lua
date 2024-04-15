local M = {}

M.setTimeout = function(timeout, callback)
	local timer = vim.uv.new_timer()
	timer:start(timeout, 0, function()
		timer:stop()
		timer:close()
		vim.schedule(callback)
	end)
	return timer
end

M.foldLines = function()
	local n_lines = vim.v.foldend - vim.v.foldstart
	local lstart = string.gsub(vim.fn.getline(vim.v.foldstart), '\t', '    ')
	local lend = string.gsub(vim.fn.getline(vim.v.foldend), '\t', '')

	local text = ('%s … %s 󰁂 %d'):format(lstart, lend, n_lines)
	return text
end

M.is_local = function()
	return not os.getenv('SSH_CONNECTION')
end

-- global search & replace
M.gsr = function()
	if #vim.fn.getqflist() == 0 then
		return vim.notify('No quickfix list found')
	end

	local input = vim.fn.input('s/<>/g: ')
	if input == '' then
		return vim.notify('No input')
	end

	vim.cmd('noa cdo s/' .. input .. '/g')
	vim.cmd('noa bufdo up | bd')
	vim.cmd.LspRestart()
end

return M
