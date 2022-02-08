local utils = require('utils')
local cmd = vim.cmd
local m = utils.map

function _G._setup_keymaps()
	vim.g.mapleader = "\\"

	-- qol, sue me
	m('i', '<C-z>', '<cmd>u<cr>')
	m('i', '<C-Z>', '<cmd>U<cr>')
	m('i', '<C-y>', '<cmd><C-R><cr>')
	m('i', '<C-s>', '<cmd>w<cr>')
	m('i', '<C-w>', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>')
	m('n', '<C-w>', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>')

	---
	m('n', '<C-j>', '<cmd>wincmd j<cr>')
	m('n', '<C-k>', '<cmd>wincmd k<cr>')
	m('n', '<C-l>', '<cmd>wincmd l<cr>')
	m('n', '<C-h>', '<cmd>wincmd h<cr>')

	m('c', 'w!!', [[<cmd>execute 'silent! write !sudo tee "%" >/dev/null' <bar> edit!<CR><cr>]])
	m('n', '<leader>su', [[<cmd>execute 'silent! write !sudo tee "%" >/dev/null' <bar> edit!<CR><cr>]])

	-- qol
	m('n', '<leader>w', '<cmd>w<cr>')
	m('n', '<leader>qq', '<cmd>q<cr>')
	m('n', '<leader>qa', '<cmd>qa<cr>')
	m('n', '<leader>Qa', '<cmd>qa!<cr>')
	m('n', '<leader>wc', '<C-w>')
	m('n', '<leader>wC', '<cmd>bp<bar>sp<bar>bn<bar>bd!<CR>')

	-- telescope
	m('n', '<leader>tt', '<cmd>Telescope<cr>')
	m('i', '<c-P>', '<cmd>Telescope<cr>')
	m('n', '<leader>tf', '<cmd>Telescope find_files prompt_prefix=🔍 theme=get_dropdown<cr>')
	m('n', '<leader>tb', '<cmd>Telescope buffers theme=get_dropdown<cr>')
	m('n', '<leader>td', '<cmd>Telescope lsp_workspace_diagnostics theme=get_dropdown<cr>')
	-- m('n', '<leader>ca', '<cmd>Telescope lsp_workspace_diagnostics theme=get_cursor<cr>') --lsp

	-- lsp

	m('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
	m('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
	-- m('n', '<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
	-- m('n', '<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
	-- m('n', '<leader>llw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
	m('n', '<leader>ren', '<cmd>lua vim.lsp.buf.rename()<cr>')
	m('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>')
	m('n', '<leader>def', '<cmd>Telescope coc definitions theme=get_cursor<cr>')
	m('n', '<leader>ref', '<cmd>Telescope coc references theme=get_cursor<cr>')
	m('n', '<leader>sym', '<cmd>Telescope coc document_symbols theme=get_dropdown<cr>')
	m('n', '<leader>ca', '<cmd>Telescope coc code_action<cr>') --lsp
end

-- bite me, coq
cmd('autocmd VimEnter,BufEnter * lua _setup_keymaps()')
