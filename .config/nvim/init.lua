-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local dir = ''
for i = 1, 4 do
	if vim.fn.isdirectory(vim.v.argv[i]) ~= 0 then
		dir = vim.v.argv[i]
		break
	end
end

if dir ~= '' then
	vim.cmd('cd ' .. dir)
end
