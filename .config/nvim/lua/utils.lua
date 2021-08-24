local utils = {}
local cmd = vim.cmd

function utils.setb(bufnr, key, value)
	vim.api.nvim_buf_set_option(bufnr, key, value)
end

function utils.mapb(bufnr, mode, lhs, rhs, opts)
	local options = { noremap = false }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function utils.map(mode, lhs, rhs, opts)
	local options = { noremap = false, silent = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.quote(str)
	return '"'..str..'"'
end

function utils.dirname(str, sep)
	sep=sep or '/'
	return str:match("(.*"..sep..")")
end

function utils.real_cwd()
	local dir = vim.v.argv[2]
	if not dir or vim.fn.isdirectory(dir) == 0 then
		dir = vim.fn.expand('%:p:h')
	end
	if vim.fn.isdirectory(dir) then
		return dir
	end
end

return utils
