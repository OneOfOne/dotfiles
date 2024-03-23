-- https://medium.com/@alpha2phi/modern-neovim-configuration-hacks-93b13283969f#6ab4
local kmset = vim.keymap.set
local function map(mode, keys, fn, desc, opts)
	kmset(mode, keys, fn, vim.tbl_extend('force', { desc = desc, noremap = true }, opts or {}))
end

local function nmap(keys, fn, desc, opts)
	map('n', keys, fn, desc, opts)
end

local function imap(keys, fn, desc, opts)
	map({ 'i', 'c' }, keys, fn, desc, opts)
end

local function vmap(keys, fn, desc, opts)
	map({ 'v', 'x' }, keys, fn, desc, opts)
end

local remap = { noremap = false, remap = true }

-- qol
imap('<c-v>', '<left><c-o>"+p', 'paste clipboard')
imap('<c-s-v>', '<left><c-o>"*p', 'paste selection')

-- this breaks ctrl-z in the terminal, but honestly, who uses that with nvim?
imap('<c-z>', '<c-o>u', 'undo')
imap('<c-r>', '<c-o><c-r>', 'redo')

-- vmap('<LeftRelease>', '"*ygv', 'yank on mouse selection')

nmap('<leader>gl', '<cmd>OpenInGHFileLines<cr>', 'open current file/line in github')

nmap('<leader>gC', '<cmd>Telescope git_bcommits<cr>', 'show commit history for file')

-- sane regexp defaults
nmap('ss', ':%s/\\v')
vmap('ss', '"zy<ESC>:%s~\\M<c-r>z~~gc<left><left><left>', 'search & replace selection in visual mode')
nmap('sds', ':.s/\\v')
nmap('sg', ':%g/\\v')
nmap('sdg', ':.g/\\v')

nmap('<leader>j', '*``cgn', 'ghetto multi cursors')
vmap('<leader>j', '*``cgn', 'ghetto multi cursors', remap)

map('', '<c-tab>', '<cmd>Telescope buffers<cr>', 'buffer list')
imap('<c-tab>', '<cmd>Telescope buffers<cr>', 'buffer list')

--
nmap('vv', ':normal! v<cr>', 'map vv to v because lazyvim overrides that')
vmap('i', '<esc>i', 'insert from visual')

nmap('<leader>us', '<cmd>setlocal spell!<cr>', 'toggle spell checking per buffer')

nmap('<leader>sudo', '<cmd>w !sudo tee "%" >/dev/null<cr><cmd>edit!<cr>', 'sudo write')

-- overrides
vmap('<cr>', '<esc>o', 'make enter insert a new line')
nmap('DD', 'dd', 'delete to clipboard')
nmap('dd', '"_dd', 'keep deleted lines from the clipboard')
nmap('x', '"_x', 'keep deleted chars from the clipboard')

nmap('<leader>tw', function()
	--https://www.reddit.com/r/neovim/comments/1bjlihf/comment/kvu63wj/
	vim.ui.input({ prompt = 'Update tab size: ' }, function(input)
		vim.opt.tabstop = tonumber(input)
		vim.opt.softtabstop = tonumber(input)
		vim.opt.shiftwidth = tonumber(input)
	end)
end, 'update tab size')
