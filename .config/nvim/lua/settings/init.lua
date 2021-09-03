local utils = require('utils')

local cmd = vim.cmd
local set = vim.opt
local g = vim.g

g.python_host_prog = '/usr/bin/python'
g.mapleader = ' '

cmd('syntax enable')
cmd('set background=dark')
cmd('filetype plugin indent on')
-- cmd('colorscheme nord')


local indent = 4
set.expandtab = false
set.shiftwidth = indent
set.smartindent = true
set.tabstop = indent

set.termguicolors = true
set.background = 'dark'
set.hidden = true
set.scrolloff = 4
set.shiftround = true

set.splitbelow = true
set.splitright = true

set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.wrapscan = true

set.completeopt = 'menuone,noinsert'
--set.shortmess += 'c'
set.wildmode = 'list:longest'
set.number = true
set.relativenumber = false
set.clipboard = 'unnamed,unnamedplus'
set.signcolumn = 'number'
set.inccommand = 'nosplit'
set.tabline = '2'
set.sidescroll = 2
set.cmdheight = 4
set.ruler = true
set.showcmd = true
set.visualbell = true
set.mouse = 'a'
set.autoindent = true
set.cursorline = true
set.laststatus = 2
set.fillchars = 'vert:│,fold:·'
set.listchars = 'tab:» ,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'
set.list = true
set.updatetime = 150
set.confirm = true
set.autochdir = false
set.swapfile = true
set.undofile = false
set.ttyfast = true

set.guifont = "SFMono Nerd Font Mono:h10"

vim.cmd([[
	au TextYankPost * lua vim.highlight.on_yank {on_visual = false}
	au BufEnter * if &buftype == 'terminal' | :startinsert | endif

	" enable jsonc
	au FileType json syntax match Comment +\/\/.\+$+
]])
