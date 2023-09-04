-- https://medium.com/@alpha2phi/modern-neovim-configuration-hacks-93b13283969f#6ab4
local map = vim.keymap.set
local nmap = function(keys, fn, desc)
	map('n', keys, fn, { desc = desc, noremap = true })
end
local imap = function(keys, fn, desc)
	map('i', keys, fn, { desc = desc, noremap = true })
end

nmap('<a-p>', '"*p', 'paste from selection')
nmap('<a-P>', '"*P', 'paste from selection')

nmap('<leader>gl', '<cmd>OpenInGHFileLines<cr>', 'open current file/line in github')
nmap('<c-tab>', '<cmd>Telescope buffers theme=dropdown previewer=false<cr>', 'simple buffer selector')

-- sane regexp defaults
nmap('/', '/\\v')
nmap('?', '?\\v')
nmap('ss', ':%s/\\v')
nmap('sds', ':.s/\\v')
nmap('sg', ':%g/\\v')
nmap('sdg', ':.g/\\v')

-- https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/
nmap('<leader>j', '*``cgn', 'ghetto multi cursors')

nmap('vv', ':normal! v<cr>', 'map vv to v because lazyvim overrides that')

nmap('<leader>us', '<cmd>setlocal spell!<cr>', 'disable spell checking per buffer')

-- old habits die hard
imap('<c-v>', '<esc>pi', 'paste in insert mode')
imap('<c-a>', '<esc>ggVG', 'select all in insert mode')

map('v', '<LeftRelease>', '"*ygv', { noremap = true, desc = 'auto yank on mouse selection' })


