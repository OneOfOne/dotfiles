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

local nvimDir = dir .. '/.nvim/'
if dir ~= '' then
	vim.cmd('cd ' .. dir)

	vim.defer_fn(function()
		-- can't require, it's effy
		if vim.fn.filereadable(nvimDir .. 'session.lua') ~= 0 then
			vim.cmd('luafile ' .. nvimDir .. 'session.lua')
		end
		if vim.fn.filereadable(nvimDir .. 'init.lua') ~= 0 then
			vim.cmd('luafile ' .. nvimDir .. 'init.lua')
		end
		vim.cmd('au Vimleave * lua save_open_files(false)')
	end, 150)




	if vim.env.WEZTERM_PANE ~= nil then
		local wezpane = tonumber(vim.env.WEZTERM_PANE)
		vim.cmd('silent! !wezterm cli split-pane --bottom --percent 20')
		vim.cmd('silent! !wezterm cli split-pane --right --pane-id ' .. wezpane + 1)
		vim.cmd('silent! !wezterm cli activate-pane --pane-id ' .. wezpane)

		vim.cmd('au Vimleave * silent! !wezterm cli kill-pane --pane-id ' .. wezpane + 1)
		vim.cmd('au Vimleave * silent! !wezterm cli kill-pane --pane-id ' .. wezpane + 2)
		if wezpane ~= 0 then
			vim.cmd('au Vimleave * silent! !wezterm cli activate-pane --pane-id ' .. wezpane - 3)
		end
	end
end

function save_open_files(only_if_exists)
	if dir == '' then
		return
	end
	if dir == '' or only_if_exists and vim.fn.filereadable(nvimDir) == 0 then
		return
	end

	if vim.fn.isdirectory(nvimDir) == 0 then
		vim.fn.mkdir(nvimDir, 'p')
	end

	local file = io.open(nvimDir .. 'session.lua', 'w')
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

-- probably should move this into the different config files
vim.cmd [[
	" using spaces as tabs is evil, and you should be ashamed of yourself
	set autoindent
	set smartindent
	set noexpandtab
	set softtabstop=0
	set shiftwidth=4
	set tabstop=4

	set iskeyword+=-
	set norelativenumber
	set wrap
	set breakindent

	set list listchars=tab:▶‒,nbsp:∙,trail:∙,extends:▶,precedes:◀,space:·
	match ErrorMsg '\s\+$'

	set title
	set noundofile

	" use cspell, because neovim's spell stupid
	set nospell
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
	nmap <leader>qw <leader>bd
	nmap <leader>b<tab> <cmd>Telescope buffers theme=dropdown previewer=false<cr>
	nmap <c-tab> <leader>b<tab>
	nmap J 25gj
	nmap k 25gk
]]
