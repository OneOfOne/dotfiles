local M = {}

function M.setb(bufnr, key, value)
	vim.api.nvim_buf_set_option(bufnr, key, value)
end

function M.mapb(bufnr, mode, lhs, rhs, opts)
	local options = { noremap = false }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = false, silent = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.quote(str)
	return '"'..str..'"'
end

function M.dirname(str, sep)
	sep=sep or '/'
	return str:match("(.*"..sep..")")
end

function M.real_cwd()
	local dir = vim.v.argv[2]
	if not dir or vim.fn.isdirectory(dir) == 0 then
		dir = vim.fn.expand('%:p:h')
	end
	if vim.fn.isdirectory(dir) then
		return dir
	end
end

function M.merge(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			M.merge(t1[k], t2[k])
		else
			t1[k] = v
		end
	end
	return t1
end

return M
