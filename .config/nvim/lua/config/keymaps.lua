-- https://medium.com/@alpha2phi/modern-neovim-configuration-hacks-93b13283969f#6ab4
local map = vim.keymap.set
local function nmap(keys, fn, desc)
	map('n', keys, fn, { desc = desc, noremap = true })
end
local function imap(keys, fn, desc)
	map({ 'i', 'c' }, keys, fn, { desc = desc, noremap = true })
end
local function vmap(keys, fn, desc)
	map('v', keys, fn, { desc = desc, noremap = true })
end

-- qol
nmap('<a-p>', '"*p', 'paste selection')
nmap('<a-P>', '"*P', 'paste selection (before)')
imap('<c-v>', '<c-r>+', 'paste clipboard')
imap('<c-V>', '<c-r>*', 'paste selection')
-- this breaks ctrl-z in the terminal, but honestly, who uses that with nvim?
imap('<c-z>', '<c-o>u', 'undo')
imap('<c-z>', '<c-o><c-r>', 'redo')

vmap('<LeftRelease>', '"*ygv', 'yank on mouse selection')

-- old habits die hard
imap('<c-a>', '<esc>ggVG', 'select all in insert mode')

nmap('<leader>gl', '<cmd>OpenInGHFileLines<cr>', 'open current file/line in github')

nmap('<c-tab>', '<cmd>Telescope buffers theme=dropdown previewer=false<cr>', 'simple buffer selector')
nmap('z=', '<cmd>Telescope spell_suggest theme=get_cursor previewer=false<cr>', 'override spelling list')

-- sane regexp defaults
nmap('ss', ':%s/\\v')
nmap('sds', ':.s/\\v')
nmap('sg', ':%g/\\v')
nmap('sdg', ':.g/\\v')

-- https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/
nmap('<leader>j', '*``cgn', 'ghetto multi cursors')

nmap('vv', ':normal! v<cr>', 'map vv to v because lazyvim overrides that')

nmap('<leader>us', '<cmd>setlocal spell!<cr>', 'disable spell checking per buffer')

-- overrides
