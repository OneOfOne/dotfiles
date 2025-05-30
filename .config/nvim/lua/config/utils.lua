local M = {}

M.setTimeout = function(timeout, callback)
	local timer = vim.uv.new_timer()
	if timer == nil then
		return nil
	end
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

M.get_hostname = function()
	local f = assert(io.popen('/bin/hostname', 'r'))
	local hostname = f:read('*l') or ''
	f:close()
	return hostname
end

M.hostname = M.get_hostname()

M.is_local = function()
	if M.hostname == 'USS-Defiant.local' or M.hostname == 'orville' then
		return true
	end
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
	vim.fn.setqflist({})
	vim.cmd('noa wall')
	vim.cmd.LspRestart()
end

M.current_line_diagnostics = function()
	local bufnr = 0
	local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
	local opts = { ['lnum'] = line_nr }

	return vim.diagnostic.get(bufnr, opts)
end

return M
