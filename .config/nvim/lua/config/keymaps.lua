---@diagnostic disable: unused-local, unused-function

-- https://medium.com/@alpha1phi/modern-neovim-configuration-hacks-93b13283969f#6ab4
local function map(mode, keys, fn, desc, opts)
	vim.keymap.set(mode, keys, fn, vim.tbl_extend('force', { desc = desc, noremap = true }, opts or {}))
end

local function nmap(keys, fn, desc, opts)
	map('n', keys, fn, desc, opts)
end

local function imap(keys, fn, desc, opts)
	map({ 'i', 'c' }, keys, fn, desc, opts)
end

local function vmap(keys, fn, desc, opts)
	map({ 'v' }, keys, fn, desc, opts)
end

local remap = { noremap = false, remap = true }

-- qol
-- map({ 'i' }, '<c-v>', '<left><c-o>"+p', 'paste clipboard')
-- map({ 'i' }, '<c-s-v>', '<left><c-o>"*p', 'paste selection')

-- this breaks ctrl-z in the terminal, but honestly, who uses that with nvim?
map({ 'i' }, '<c-z>', '<c-o>u', 'undo')
map({ 'i' }, '<c-r>', '<c-o><c-r>', 'redo')

nmap('<RightMouse>', '<LeftMouse>', 'reassign right mouse button to left')

-- reassign (shift|ctrl)-(left|right) mouse to just left, otherwise they don't work in vmap
nmap('<S-LeftMouse>', '<LeftMouse>')
map({ 'n', 'v' }, '<S-LeftDrag>', '<LeftDrag>')

nmap('<S-RightMouse>', '<LeftMouse>')
map({ 'n', 'v' }, '<S-RightDrag>', '<LeftDrag>')

nmap('<C-LeftMouse>', '<LeftMouse>')
map({ 'n', 'v' }, '<C-LeftDrag>', '<LeftDrag>')

nmap('<C-RightMouse>', '<LeftMouse>')
map({ 'n', 'v' }, '<C-RightDrag>', '<LeftDrag>')

vmap('<LeftRelease>', '"*ygv<esc>', 'yank selection to *')
vmap('<S-LeftRelease>', '<LeftRelease>', '')
vmap('<S-RightRelease>', '"*dgv<esc>', 'delete selection to *')
vmap('<C-LeftRelease>', '"*P', 'replace selection with *')

nmap('<leader>gl', '<cmd>OpenInGHFileLines<cr>', 'open current file/line in github')

-- sane regexp defaults
-- nmap('ss', ':%s/\\v')
-- vmap('ss', '"zy<ESC>:%s~\\M<c-r>z~~gc<left><left><left>', 'search & replace selection in visual mode')
-- nmap('sds', ':.s/\\v')
-- nmap('sg', ':%g/\\v')
-- nmap('sdg', ':.g/\\v')

-- convenience
nmap('<leader>j', '*``cgn', 'ghetto multi cursors')
vmap('<leader>j', '*``cgn', 'ghetto multi cursors', remap)

map({ '', 'i' }, '<c-tab>', '<cmd>Telescope buffers<cr>', 'buffer list')

nmap('vv', ':normal! v<cr>', 'map vv to v because lazyvim overrides that')
nmap('<home>', '^', 'make home go to the beginning of indentation')
map({ '' }, 'J', ':s/\\n/, /<cr>o<esc>k$', 'join lines with ,')

nmap('k', '5k', 'because 5k is better than 1k')
nmap('j', '5j', 'because 5j is better than 1j')

nmap('<bs>', '<c-o>', 'backspace to ctrl-o')
vmap('<cr>', '<esc>o', 'make enter insert a new line')

nmap('+', '<cmd>vert res +5<cr>')
nmap('-', '<cmd>vert res -5<cr>')

-- overrides
nmap('DD', 'dd', 'delete to clipboard')
nmap('dd', '"_dd', 'keep deleted lines from the clipboard')
nmap('x', '"_x', 'keep deleted chars from the clipboard')

--- misc
nmap('<leader>us', '<cmd>setlocal spell!<cr>', 'toggle spell checking per buffer')
nmap('<leader>sudo', '<cmd>w !sudo tee "%" >/dev/null<cr><cmd>edit!<cr>', 'sudo write')

nmap('<leader>tw', function()
	--https://www.reddit.com/r/neovim/comments/1bjlihf/comment/kvu63wj/
	vim.ui.input({ prompt = 'Update tab size: ' }, function(input)
		vim.opt.tabstop = tonumber(input)
		vim.opt.softtabstop = tonumber(input)
		vim.opt.shiftwidth = tonumber(input)
	end)
end, 'update tab size')
