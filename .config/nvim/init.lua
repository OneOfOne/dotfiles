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

vim.cmd [[
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

	au BufLeave * silent! wall
]]
