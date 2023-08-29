-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local dir = ''
local argv = vim.fn.argv()
for i = 1, vim.fn.argc() do
	if vim.fn.isdirectory(argv[i]) ~= 0 then
		dir = argv[i]
		break
	end
end

local sessionFile = dir .. '/.git/lastsession.lua'
if dir ~= '' then
	vim.cmd('cd ' .. dir)
	if vim.fn.filereadable(sessionFile) ~= 0 then
		vim.schedule(function()
			-- can't require, it's effy
			vim.cmd('luafile ' .. sessionFile)
		end)
	end

	vim.cmd [[
		au Vimleave * lua save_open_files(false)
	]]


	if vim.env.WEZTERM_PANE ~= '' then
		local wezpane = tonumber(vim.env.WEZTERM_PANE)

		vim.cmd('silent! !wezterm cli split-pane --bottom --percent 20')
		vim.cmd('silent! !wezterm cli split-pane --right --pane-id ' .. wezpane + 1)
		vim.cmd('silent! !wezterm cli  activate-pane --pane-id ' .. wezpane)

		vim.cmd('au Vimleave * silent! !wezterm cli kill-pane --pane-id ' .. wezpane + 1)
		vim.cmd('au Vimleave * silent! !wezterm cli kill-pane --pane-id ' .. wezpane + 2)
		if wezpane ~= 0 then
			vim.cmd('au Vimleave * silent! !wezterm cli  activate-pane --pane-id ' .. wezpane - 2)
		end
	end
end

function save_open_files(only_if_exists)
	if dir == '' then
		return
	end
	if dir == '' or only_if_exists and vim.fn.filereadable(sessionFile) == 0 then
		return
	end

	local file = io.open(sessionFile, "w")
	file:write('local utils = require("neo-tree.utils");\n');
	for i, h in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(h) then
			local bname = vim.api.nvim_buf_get_name(h)
			local name = '.' .. bname:sub(vim.fs.normalize(dir):len() + 1)
			if vim.fn.filereadable(name) ~= 0 then
				found = true
				file:write('utils.open_file({}, "' .. name .. '");\n')
			end
		end
	end
	file:close()
end

function tprint(tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
		formatting = string.rep("\t", indent) .. k .. ": "
		if type(v) == "table" then
			print(formatting)
			tprint(v, indent + 1)
		elseif type(v) == 'boolean' then
			print(formatting .. tostring(v))
		else
			print(formatting .. v)
		end
	end
end

-- probably should use lua, but oh well
vim.cmd [[
	" using spaces as tabs is evil, and you should be ashamed of yourself
	set autoindent
	set smartindent
	set noexpandtab
	set softtabstop=0
	set shiftwidth=2
	set tabstop=2

	set iskeyword+=-
	set norelativenumber
	set wrap
	set breakindent

	set list listchars=tab:▶‒,nbsp:∙,trail:∙,extends:▶,precedes:◀,space:·
	match ErrorMsg '\s\+$'

	set title
	set noundofile

	" set spell
	set spelloptions+=camel

	set completeopt+=noinsert

	" autosave
	set autowriteall
	au BufLeave * silent! wall

	" fix selection with mouse
	vmap <LeftRelease> "*ygv

	" old habits die hard
	imap <c-v> <esc>pi
	imap <c-a> <esc>ggVG

	nmap <leader>gl <cmd>OpenInGHFileLines<cr>
]]
