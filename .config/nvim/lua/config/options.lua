-- some settings from https://github.com/Aumnescio/dotfiles/blob/main/nvim/init.lua

local o = vim.opt

o.autoindent = true
o.smartindent = false

o.expandtab = false
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4

---@diagnostic disable-next-line: undefined-field
o.iskeyword:append('-')

-- o.iskeyword:append('.')
o.relativenumber = true
o.wrap = true
o.scrolloff = 0
o.smoothscroll = true

o.list = true
local sp = '‧'
o.listchars = { tab = '┃ ', nbsp = sp, trail = sp, lead = sp, space = sp, extends = '▶', precedes = '◀' } -- , eol = '↴'
-- o.listchars = { tab = '┃ ', nbsp = sp, trail = sp, lead = sp, extends = '▶', precedes = '◀' } -- , eol = '↴'
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
-- vim.cmd([[match ErrorMsg '\s\+$']])

o.title = true

o.copyindent = true
o.breakindent = true
o.breakindentopt = 'sbr'
o.showbreak = '❯ '
o.startofline = true

o.paste = false
---@diagnostic disable-next-line: undefined-field
o.clipboard:append('unnamed')

o.undofile = false
o.swapfile = false
o.shada = "!,'50,<50,s10,h,r/tmp"
o.shadafile = 'NONE'

o.spell = true
o.spelloptions:append('camel')

---@diagnostic disable-next-line: undefined-field
o.completeopt:append('noinsert')

o.grepprg = 'rg --hidden --vimgrep'
--
o.timeout = false
-- o.timeoutlen = 50
-- o.ttimeoutlen = 10
-- o.updatetime = 250

-- better selection
o.selection = 'inclusive'
o.virtualedit = 'onemore'
-- o.selectmode = 'mouse,key'
o.mousemodel = 'extend'
o.winborder = 'rounded'

o.foldlevelstart = -1

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_scale_factor = 1
vim.g.neovide_window_blurred = true
vim.g.neovide_opacity = 0.1
vim.g.neovide_normal_opacity = 0.1

-- o.guicursor = 'a:block-blinkwait500-blinkon500-blinkoff500'
-- vim.g.neovide_cursor_smooth_blink = true
--
vim.o.foldmethod = 'expr'
vim.o.foldtext = "v:lua.require('config.utils').foldLines()"

o.autowriteall = true

if require('config.utils').is_local() then
	vim.g.lazyvim_blink_main = true
end

vim.g.lazyvim_eslint_auto_format = false
-- vim.g.ai_cmp = true
-- vim.g.copilot_nes = false
