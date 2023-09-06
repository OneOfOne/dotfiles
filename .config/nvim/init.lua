if not vim.uv then
	vim.uv = vim.loop
end

require("config.lazy")
require("config.abbr")

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

function OpenFile(fn)
	if vim.fn.filereadable(fn) ~= 0 then
		require("neo-tree.utils").open_file({}, fn)
	end
end

local function writefile(fn, text)
	local file = io.open(fn, 'w')
	if not file then
		return
	end
	file:write(text)
	file:close()
end

function SaveSession(only_if_exists)
	if dir == '' or only_if_exists and vim.fn.filereadable(nvimDir .. 'session.lua') == 0 then
		return
	end

	if vim.fn.isdirectory(nvimDir) == 0 then
		vim.fn.mkdir(nvimDir, 'p')
		writefile(nvimDir .. '.gitignore', 'session.lua\nshada\n')
	end

	if vim.fn.filereadable(nvimDir .. 'init.lua') == 0 then
		writefile(nvimDir .. 'init.lua', 'vim.opt.shadafile = "./.nvim/shada"\nvim.cmd("rshada")\nreturn {}\n')
		writefile(nvimDir .. 'shada', '')
	end

	local file = io.open(nvimDir .. 'session.lua', 'w')

	if not file then
		return
	end

	file:write('return {\n');
	for _, h in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(h) then
			local bname = vim.api.nvim_buf_get_name(h)
			local name = '.' .. bname:sub(vim.fs.normalize(dir):len() + 1)
			if vim.fn.filereadable(name) ~= 0 then
				file:write('\t"' .. name .. '",\n')
			end
		end
	end
	file:write('}\n')
	file:close()
end

function DeleteSession()
	if vim.fn.filereadable(nvimDir .. 'session.lua') then
		os.remove(nvimDir .. 'session.lua')
	end
end

if dir ~= '' then
	vim.cmd('cd ' .. dir)

	local opts = {};
	vim.defer_fn(function()
		if vim.fn.filereadable(nvimDir .. 'init.lua') ~= 0 then
			local data = dofile(nvimDir .. 'init.lua')
			if data ~= nil then
				vim.tbl_extend('force', opts, data)
			end
		end
		if vim.fn.filereadable(nvimDir .. 'session.lua') ~= 0 then
			for _, fn in ipairs(dofile(nvimDir .. 'session.lua')) do
				OpenFile(fn)
			end
		end
		vim.cmd('au Vimleave * lua SaveSession(true)')
	end, 150)

	if not opts.noterm then
		if vim.env.WEZTERM_PANE ~= nil then
			local wezpane = tonumber(vim.env.WEZTERM_PANE)
			vim.cmd('silent! !wezterm cli split-pane --bottom --percent 20')
			vim.cmd('silent! !wezterm cli split-pane --right --percent 65 --pane-id ' .. wezpane + 1)
			vim.cmd('silent! !wezterm cli activate-pane --pane-id ' .. wezpane)

			vim.cmd('au Vimleave * silent! !wezterm cli kill-pane --pane-id ' .. wezpane + 1)
			vim.cmd('au Vimleave * silent! !wezterm cli kill-pane --pane-id ' .. wezpane + 2)
			if wezpane ~= 0 then
				vim.cmd('au Vimleave * silent! !wezterm cli activate-pane --pane-id ' .. wezpane - 3)
			end
		end
	end
end
