local utils = require('utils')

local cmd = vim.cmd
local set = vim.opt
vim.g.mapleader = ' '

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
set.ignorecase = true
set.scrolloff = 4
set.shiftround = true
set.smartcase = true
set.splitbelow = true
set.splitright = true
set.completeopt = 'menuone,noinsert,noselect'
--set.shortmess += 'c'
set.wildmode = 'list:longest'
set.number = true
set.relativenumber = false
set.clipboard = 'unnamed,unnamedplus'
set.signcolumn = 'yes:2'
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
set.listchars = 'tab:» ,trail:·,extends:◣,precedes:◢,nbsp:○'
set.list = true
set.updatetime = 300
set.confirm = true
set.autochdir = false
set.swapfile = false
set.undofile = true
set.ttyfast = true

set.guifont = "SFMono Nerd Font Mono:h10"

vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
