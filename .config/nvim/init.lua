if not vim.uv then
	vim.uv = vim.loop
end

require('config.lazy')
require('config.abbr')

local dir = ''
local nvimDir = ''

local argv = vim.fn.argv()
if argv then
	for i = 1, #argv do
		if vim.fn.isdirectory(argv[i]) ~= 0 then
			dir = argv[i] .. '/'
			break
		end
	end
end

if dir ~= '' then
	dir = require('plenary.path'):new(dir):absolute()
	dir = string.gsub(dir, '/$', '') .. '/'
	nvimDir = dir .. '.nvim/'
end

if dir ~= '' then
	vim.cmd('cd ' .. dir)
	if vim.env.WEZTERM_PANE ~= nil then
		local wezpane = tonumber(vim.env.WEZTERM_PANE)
		vim.cmd('silent! !wezterm cli split-pane --bottom --percent 15')
		vim.cmd('silent! !wezterm cli split-pane --right --percent 65 --pane-id ' .. wezpane + 1)
		vim.cmd('silent! !wezterm cli activate-pane --pane-id ' .. wezpane)

		vim.cmd('au Vimleave * silent! !wezterm cli kill-pane --pane-id ' .. wezpane + 1)
		vim.cmd('au Vimleave * silent! !wezterm cli kill-pane --pane-id ' .. wezpane + 2)
		if wezpane ~= 0 then
			vim.cmd('au Vimleave * silent! !wezterm cli activate-pane --pane-id ' .. wezpane - 3)
		end
	end
end
