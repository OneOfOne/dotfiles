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
	local f = io.popen('/bin/hostname')
	if f == nil then
		return ''
	end
	local hostname = f:read('*a') or ''
	f:close()
	hostname = string.gsub(hostname, '\n$', '')
	return hostname
end

M.is_local = function()
	local hn = M.get_hostname()
	if hn == 'USS-Defiant' or hn == 'orville' then
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

return M
