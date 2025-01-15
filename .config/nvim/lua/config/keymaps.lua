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
	map({ 'v', 'x' }, keys, fn, desc, opts)
end

local remap = { noremap = false, remap = true }

-- qol
-- map({ 'i' }, '<c-v>', '<left><c-o>"+p', 'paste clipboard')
map({ 'i' }, '<c-s-v>', '<left><c-o>"*p', 'paste selection')
map({ 't' }, '<c-s-v>', '<c-\\><c-n>"*pi', 'paste selection')
nmap('yc', 'yy<cmd>normal gcc<CR>p', 'copy line and comment prev') -- thank you reddit
nmap(
	'<leader>vp',
	':lua require("nvim-treesitter.incremental_selection").init_selection()<cr>P',
	'replace with clipboard'
)

nmap('<leader>vc', ':lua require("nvim-treesitter.incremental_selection").init_selection()<cr>"_c', 'change node')
nmap('<leader>vd', ':lua require("nvim-treesitter.incremental_selection").init_selection()<cr>"_d', 'delete node')

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

nmap('<leader>gl', '<cmd>OpenInGHFileLines<cr>', 'open current file/line in github')

-- convenience
-- vmap('<leader>j', 'zy:%s%\\V<C-r>0%%gc<left><left><left>', 'Search/replace visual')
vmap('<leader>j', '""y<cmd>let @/=escape(@", "/[].*$^~")<cr>"_cgn', 'Search/replace visual')

nmap('vv', ':normal! v<cr>', 'map vv to v because lazyvim overrides that')
nmap('<home>', '^', 'make home go to the beginning of indentation')
map({ '' }, 'J', ':s/\\n/, /<cr>o<esc>k$', 'join lines with ,')

nmap('k', '5k', 'because 5k is better than 1k')
nmap('j', '5j', 'because 5j is better than 1j')

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
	---@diagnostic disable-next-line: missing-fields
	vim.ui.input({ prompt = 'Update tab size: ' }, function(input)
		vim.opt.tabstop = tonumber(input)
		vim.opt.softtabstop = tonumber(input)
		vim.opt.shiftwidth = tonumber(input)
	end)
end, 'update tab size')
