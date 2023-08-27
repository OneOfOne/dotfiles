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
	if vim.fn.filereadable('.lastsession') ~= 0 then
		vim.schedule(function ()
			vim.cmd [[
				source .lastsession
				sleep 100ms
				blast
			]]
		end)
	end
end

function save_open_files(only_if_exists)
	if dir == '' then
		return
	end
	if dir == '' or only_if_exists and vim.fn.filereadable('.lastsession') == 0 then
		return
	end

	local file = io.open(".lastsession", "w")
	for i, h in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(h) then
			local bname = vim.api.nvim_buf_get_name(h)
			local name = '.' .. bname:sub(vim.fs.normalize(dir):len() + 1)
			if vim.fn.filereadable(name) ~= 0 then
				found = true
				file:write('e ' .. name .. "\n")
			end
		end
	end
	file:close()
end

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

	set completeopt+=noinsert

	" autosave
	set autowriteall
	au BufLeave * silent! wall
	au Vimleave * lua save_open_files(true)

	" old habits die hard
	imap <c-v> <esc>pi
	imap <c-a> <esc>ggVG
]]
