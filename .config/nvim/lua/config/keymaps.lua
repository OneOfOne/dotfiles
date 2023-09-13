-- https://medium.com/@alpha2phi/modern-neovim-configuration-hacks-93b13283969f#6ab4
local kmset = vim.keymap.set
local function map(keys, fn, desc, opts)
	kmset('', keys, fn, vim.tbl_extend('force', { desc = desc, noremap = true }, opts or {}))
end

local function nmap(keys, fn, desc)
	kmset('n', keys, fn, { desc = desc, noremap = true })
end
local function imap(keys, fn, desc)
	kmset({ 'i', 'c' }, keys, fn, { desc = desc, noremap = true })
end
local function vmap(keys, fn, desc)
	kmset('v', keys, fn, { desc = desc, noremap = true })
end
local function tmap(keys, fn, desc)
	kmset('t', keys, fn, { desc = desc, noremap = true })
end
-- qol
nmap('<a-p>', '"*p', 'paste selection')
nmap('<a-P>', '"*P', 'paste selection (before)')
imap('<c-v>', '<c-o>"+p', 'paste clipboard')
imap('<c-V>', '<c-o>"*p', 'paste selection')
-- this breaks ctrl-z in the terminal, but honestly, who uses that with nvim?
imap('<c-z>', '<c-o>u', 'undo')
imap('<c-r>', '<c-o><c-r>', 'redo')

vmap('<LeftRelease>', '"*ygv', 'yank on mouse selection')

map('<leader>gl', '<cmd>OpenInGHFileLines<cr>', 'open current file/line in github')

map('<c-tab>', '<cmd>Telescope buffers theme=dropdown previewer=false<cr>', 'simple buffer selector')
map('z=', '<cmd>Telescope spell_suggest theme=get_cursor previewer=false<cr>', 'use telescope for spelling suggestion')

-- sane regexp defaults
map('ss', ':%s/\\v')
map('sds', ':.s/\\v')
map('sg', ':%g/\\v')
map('sdg', ':.g/\\v')

map('<leader>j', '*``cgn', 'ghetto multi cursors')

--
nmap('vv', ':normal! v<cr>', 'map vv to v because lazyvim overrides that')
vmap('i', '<esc>i', 'insert from visual')

nmap('<leader>us', '<cmd>setlocal spell!<cr>', 'disable spell checking per buffer')

map('<leader>sudo', '<cmd>w !sudo tee "%" >/dev/null<cr><cmd>edit!<cr>', 'sudo write')

-- overrides
vmap('<cr>', '<esc>o', 'make enter insert a new line')

tmap('<MouseDown>', 'i', 'auto insert when clicking the terminal')
