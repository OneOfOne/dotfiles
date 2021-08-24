local utils = require('utils')
local cmd = vim.cmd
local m = utils.map

function _G._setup_keymaps()
	-- qol, sue me
	m('i', '<C-z>', '<cmd>u<cr>')
	m('i', '<C-Z>', '<cmd>U<cr>')
	m('i', '<C-y>', '<cmd><C-R><cr>')
	m('i', '<C-s>', '<cmd>w<cr>')
	m('i', '<C-w>', '<cmd><leader>wc<cr>')
	m('n', '<C-w>', '<cmd><leader>wc<cr>')
	m('n', 'U', '<cmd>MundoToggle<cr>')
	---
	m('n', '<C-j>', '<cmd>wincmd j<cr>')
	m('n', '<C-k>', '<cmd>wincmd k<cr>')
	m('n', '<C-l>', '<cmd>wincmd l<cr>')
	m('n', '<C-h>', '<cmd>wincmd h<cr>')

	m('c', 'w!!', '<cmd>w !sudo tee % >/dev/null <cr>')

	-- qol
	m('n', '<leader>ws', '<cmd>w<cr>')
	m('n', '<leader>qq', '<cmd>q<cr>')
	m('n', '<leader>qa', '<cmd>qa<cr>')
	m('n', '<leader>Qa', '<cmd>qa!<cr>')
	m('n', '<leader>wc', '<cmd>BufferClose<cr>')
	m('n', '<leader>wC', '<cmd>BufferClose!<cr>')
	m('n', '<leader>su', '<cmd>w!!<cr>')

	-- telescope
	m('n', '<leader>tf', '<cmd>Telescope find_files find_command=rg prompt_prefix=🔍 theme=get_dropdown<cr>')
	m('n', '<leader>tb', '<cmd>Telescope buffers theme=get_dropdown<cr>')
	m('n', '<leader>td', '<cmd>Telescope lsp_workspace_diagnostics theme=get_dropdown<cr>')
	-- m('n', '<leader>ca', '<cmd>Telescope lsp_workspace_diagnostics theme=get_cursor<cr>') --lsp
	m('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>') --lsp

	-- lsp

	m('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<cr>')
	m('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<cr>')
	m('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<cr>')
	m('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
	m('n', 'S', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	m('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
	m('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
	m('n', '<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
	m('n', '<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
	m('n', '<leader>llw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
	m('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
	m('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<cr>')
	m('n', '<leader>lrf', '<cmd>lua vim.lsp.buf.references()<cr>')
	m('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>')
end

cmd('autocmd VimEnter * lua _setup_keymaps()')
