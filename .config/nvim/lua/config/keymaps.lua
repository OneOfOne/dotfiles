---@diagnostic disable: unused-local, unused-function
-- https://medium.com/@alpha1phi/modern-neovim-configuration-hacks-93b13283969f#6ab4
local function map(mode, keys, fn, desc, opts)
	vim.keymap.set(mode, keys, fn, vim.tbl_extend('force', { desc = desc, noremap = true, remap = false }, opts or {}))
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
-- map({ 'i' }, '<c-v>', '<left><c-o>"+p', 'paste clipboard')
map({ 'i' }, '<c-s-v>', '<left><c-o>"*p', 'paste selection')
map({ 't' }, '<c-s-v>', '<c-\\><c-n>"*pi', 'paste selection')

map('', '<LeftRelease>', function()
	if vim.bo.ft == 'snacks_terminal' then
		return '<LeftRelease>i'
	end
	return '<LeftRelease>'
end, '', { expr = true })

map('', '<MiddleRelease>', function()
	if vim.bo.ft == 'snacks_terminal' then
		return '<MiddleRelease>i'
	end
	return '<MiddleRelease>'
end, '', { expr = true })

map({ 't' }, '<buffer><LeftRelease>', '<c-\\><c-n>i', 'paste selection')

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

-- convenience
-- vmap('<leader>j', 'zy:%s%\\V<C-r>0%%gc<left><left><left>', 'Search/replace visual')
nmap('<leader>j', '<cmd>let @/=expand("<cword>")<cr>cgn', 'Search/replace normal')
vmap('<leader>j', '""y<cmd>let @/=escape(@", "/[].*$^~")<cr>"_cgn', 'Search/replace visual')

nmap('vv', ':normal! v<cr>', 'map vv to v because lazyvim overrides that')
nmap('<home>', '^', 'make home go to the beginning of indentation')
map({ '' }, 'J', ':s/\\n/, /<cr>o<esc>k$', 'join lines with ,')

nmap('k', '5k', 'because 5k is better than 1k')
nmap('j', '5j', 'because 5j is better than 1j')

vmap('<cr>', '<esc>o', 'make enter insert a new line')

-- overrides
nmap('<leader>yy', '_yg_', 'trim yank')
nmap('D', 'dd', 'keep deleted lines from the clipboard')
nmap('dd', '"_dd', 'keep deleted lines from the clipboard')
nmap('x', '"_x', 'keep deleted lines from the clipboard')
nmap('yc', function()
	vim.cmd('normal! ' .. vim.v.count1 .. 'zyy')
	vim.cmd('normal ' .. vim.v.count1 .. 'gcc')
	vim.cmd("normal! ']zp")
end, 'copy line and comment prev') -- thank you reddit

if require('config.utils').is_local() then
	nmap('<leader>gg', '<cmd>!kitty lazygit<cr>', 'lazygit in kitty')
end
--- misc
nmap('<leader>sudo', '<cmd>w !sudo tee "%" >/dev/null<cr><cmd>edit!<cr>', 'sudo write')

nmap('<leader>tw', function()
	--https://www.reddit.com/r/neovim/comments/1bjlihf/comment/kvu63wj/
	---@diagnostic disable-next-line: missing-fields
	vim.ui.input({ prompt = 'Update tab size: ' }, function(input)
		vim.opt.tabstop = tonumber(input)
		vim.opt.softtabstop = tonumber(input)
		vim.opt.shiftwidth = tonumber(input)
	end)
end, 'update tab size')

vim.keymap.set('n', '<C-d>', function()
	vim.wo.scrolloff = 999
	vim.defer_fn(function()
		vim.wo.scrolloff = 8
	end, 500)
	return '<c-d>'
end, { expr = true })

vim.keymap.set('n', '<C-u>', function()
	vim.wo.scrolloff = 999
	vim.defer_fn(function()
		vim.wo.scrolloff = 8
	end, 500)
	return '<c-u>'
end, { expr = true })
