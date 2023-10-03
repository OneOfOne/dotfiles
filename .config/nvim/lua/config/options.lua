-- some settings from https://github.com/Aumnescio/dotfiles/blob/main/nvim/init.lua

local o = vim.opt

o.autoindent = true
o.smartindent = false
o.indentexpr = 'nvim_treesitter#indent()'

o.expandtab = false
o.softtabstop = 3
o.shiftwidth = 3
o.tabstop = 3

o.iskeyword:append('-')
-- o.iskeyword:append('.')
o.relativenumber = true
o.wrap = true
o.scrolloff = 0
o.smoothscroll = true

o.list = true
-- o.listchars:append({ tab = '│‒', nbsp = '∙', trail = '∙', extends = '▶', precedes = '◀', space = '·' }) -- , eol = '↴'
o.listchars:append({ tab = '▎ ', nbsp = '∙', trail = '∙', extends = '▶', precedes = '◀', space = '·' }) -- , eol = '↴'
o.fillchars:append({ fold = ' ' })
vim.cmd([[match ErrorMsg '\s\+$']])

o.title = true

o.copyindent = true
o.breakindent = true
o.breakindentopt = 'sbr'
o.showbreak = '❯ '

o.paste = false
o.clipboard:append('unnamed')

o.undofile = false
o.swapfile = false
o.shada = "!,'50,<50,s10,h,r/tmp"
o.shadafile = 'NONE'

o.spell = true
o.spelloptions:append('camel')

o.completeopt:append('noinsert')

o.grepprg = 'rg --hidden --vimgrep'

o.ttimeout = false
o.updatetime = 50

-- better selection
o.selection = 'inclusive'
o.virtualedit = 'onemore'
-- o.selectmode = 'mouse,key'
o.mousemodel = 'extend'

-- o.guifont = 'Liga SFMono Nerd Font,Noto Color Emoji,Noto Sans Symbols,Noto Sans Symbols 2:h10'
o.guifont = 'Liga SFMono Nerd Font:h10'

function FoldWithNlines()
	local text = vim.treesitter.foldtext()
	local n_lines = vim.v.foldend - vim.v.foldstart

	---@diagnostic disable-next-line: param-type-mismatch
	table.insert(text, { (' 󰁂 %d '):format(n_lines), { 'Folded' } })
	return text
end

vim.opt.foldtext = 'v:lua.FoldWithNlines()'
