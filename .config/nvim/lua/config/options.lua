-- some settings from https://github.com/Aumnescio/dotfiles/blob/main/nvim/init.lua

local o = vim.opt

o.autoindent = true
o.smartindent = true
o.expandtab = false
o.softtabstop = 0
o.shiftwidth = 4
o.tabstop = 4

o.iskeyword:append('-')
-- o.iskeyword:append('.')
o.relativenumber = true
o.wrap = true
o.scrolloff = 0
o.smoothscroll = true

o.list = true
-- o.listchars:append({ tab = '│‒', nbsp = '∙', trail = '∙', extends = '▶', precedes = '◀', space = '·' }) -- , eol = '↴'
o.listchars:append({ tab = '│ ', nbsp = '∙', trail = '∙', extends = '▶', precedes = '◀', space = '·' }) -- , eol = '↴'
o.fillchars:append({ fold = ' ' })
vim.cmd [[match ErrorMsg '\s\+$']]

o.title          = true

o.copyindent     = true
o.breakindent    = true
o.breakindentopt = 'sbr'
o.showbreak      = '❯ '

o.paste          = false
o.clipboard:append('unnamed')

o.undofile = false
o.swapfile = false
o.shada = '!,\'50,<50,s10,h,r/tmp'
o.shadafile = 'NONE'

o.spell = true
o.spelloptions:append('camel')

o.completeopt:append('noinsert')

o.grepprg = 'rg --hidden --vimgrep'

o.ttimeout = false
o.updatetime = 26

-- better selection
o.selection = 'inclusive'
o.virtualedit = 'onemore'
-- o.selectmode = 'mouse,key'
o.mousemodel = 'extend'

o.indentexpr = 'nvim_treesitter#indent()'
-- fold stuff
o.foldcolumn = '1'
o.foldlevel = 99
o.foldlevelstart = -1
o.foldenable = true
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldtext = 'v:lua.SmartFold()'

function SmartFold()
	local indent = vim.fn.indent(vim.v.foldstart) or 0
	local ichar = string.rep('‒', indent)
	---@diagnostic disable-next-line: param-type-mismatch
	return ichar .. vim.fn.getline(vim.v.foldstart) .. ' ... ' .. vim.fn.getline(vim.v.foldend):gsub('^%s*', '')
end

-- o.guifont = 'Liga SFMono Nerd Font,Noto Color Emoji,Noto Sans Symbols,Noto Sans Symbols 2:h10'
o.guifont = 'Liga SFMono Nerd Font:h10'
o.linespace = -1
