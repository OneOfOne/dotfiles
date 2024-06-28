-- some settings from https://github.com/Aumnescio/dotfiles/blob/main/nvim/init.lua

local o = vim.opt

o.autoindent = true
o.smartindent = false

o.expandtab = false
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4

o.iskeyword:append('-')
-- o.iskeyword:append('.')
o.relativenumber = true
o.wrap = true
o.scrolloff = 1
o.smoothscroll = true

o.list = true
local sp = '∙'
o.listchars = { tab = '┃ ', nbsp = sp, trail = sp, lead = sp, space = sp, extends = '▶', precedes = '◀' } -- , eol = '↴'
o.fillchars = {
	fold = ' ',
	foldclose = '▶',
	foldopen = '',
	horiz = '━',
	horizup = '━',
	horizdown = '━',
	-- horizup = '┻',
	-- horizdown = '┳',
	vert = '┃',
	--vertleft = '┫',
	vertleft = '┃',
	vertright = '┃',
	-- vertright = '┣',
	verthoriz = '╋',
}
vim.cmd([[match ErrorMsg '\s\+$']])

o.title = true

o.copyindent = true
o.breakindent = true
o.breakindentopt = 'sbr'
o.showbreak = '❯ '
o.startofline = true

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

o.timeoutlen = 500
o.ttimeoutlen = 100
o.updatetime = 250

-- better selection
o.selection = 'inclusive'
o.virtualedit = 'onemore'
-- o.selectmode = 'mouse,key'
o.mousemodel = ''

o.foldmethod = 'indent'
o.foldlevelstart = -1

o.guifont = 'ComicShannsMono Nerd Font,Noto Sans Symbols,Noto Sans Symbols 2:h12'
-- o.guifont = 'iMWritingMono Nerd Font,Noto Sans Symbols,Noto Sans Symbols 2:h12'
-- o.guifont = 'MonoLisa Nerd Font Mono,Noto Sans Symbols,Noto Sans Symbols 2:h11'
-- o.guifont = 'GeistMono Nerd Font,Noto Sans Symbols,Noto Sans Symbols 2:h12'
-- o.guifont = 'SeriousShanns Nerd Font Mono,Noto Sans Symbols,Noto Sans Symbols 2:h12'
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_refresh_rate = 120
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_scale_factor = 1

-- local utils = require('config.utils')
--
-- -- something keeps overriding foldexpr
-- utils.setTimeout(250, function()
-- 	vim.o.foldmethod = 'indent'
-- 	vim.o.foldtext = "v:lua.require('config.utils').foldLines()"
-- 	vim.o.foldexpr = "v:lua.require('lazyvim.util').ui.foldexpr()"
-- end)
--
--
