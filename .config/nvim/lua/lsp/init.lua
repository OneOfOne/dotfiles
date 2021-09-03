local lsp = require('lspconfig')
local utils = require('utils')
local m = utils.map
local g = vim.g
local cmd = vim.cmd

require('lspkind').init({
	with_text = true,
	symbol_map = {
		Text = '',
		Method = 'ƒ',
		Function = '',
		Constructor = '',
		Variable = '',
		Class = '',
		Interface = 'ﰮ',
		Module = '',
		Property = '',
		Unit = '',
		Value = '',
		Enum = '了',
		Keyword = '',
		Snippet = '﬌',
		Color = '',
		File = '',
		Folder = '',
		EnumMember = '',
		Constant = '',
		Struct = ''
	},
})
g.completion_enable_auto_popup = 1
g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}
g.completion_matching_smart_case = 1
g.completion_timer_cycle = 100
-- g.completion_chain_complete_list = {
-- 	default	= {
-- 			{complete_items = {'lsp', 'snippet'}},
-- 			{complete_items = {'path'}, triggered_only = {'/'}},
-- 			{complete_items = {'buffers'}},
-- 	}
-- }

local M = {}

local on_attach = function(client, bufnr)
	-- https://github.com/neovim/neovim/pull/13165
	cmd([[
		set shortmess+=c
		augroup lsp_]] .. client.name .. [[
			au! * <buffer>
			au CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
			inoremap <expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"
			inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"
	]])

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<cr>", {silent = true})
	local rcaps = client.resolved_capabilities
	if rcaps.document_range_formatting or rcaps.document_formatting then
		cmd([[
			au BufWritePre <buffer> lua require('lsp').org_imports(3000)
			au BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
		]])
	end
	if rcaps.document_highlight then
		cmd([[
			hi LspReferenceRead ctermfg=235 ctermbg=142 guifg=#323d43 guibg=#a7c080
			hi LspReferenceText ctermfg=235 ctermbg=142 guifg=#323d43 guibg=#a7c080
			hi LspReferenceWrite ctermfg=235 ctermbg=142 guifg=#323d43 guibg=#a7c080
			augroup LSP
				au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
	end
	cmd('augroup END')
	require('completion').on_attach(client, bufnr);
end

local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true

function M.setup(name, init_opts)
	lsp[name].setup({
		capabilities = caps,
		on_attach = on_attach,
		init_options = init_opts,
		flags = {
			onlyAnalyzeProjectsWithOpenFiles = true,
			suggestFromUnimportedLibraries = true,
			closingLabels = true,
			debounce_text_changes = 200,
		}
	})
end

function M.org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = {only = {"source.organizeImports"}}
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
	  for _, r in pairs(res.result or {}) do
		if r.edit then
		  vim.lsp.util.apply_workspace_edit(r.edit)
		else
		  vim.lsp.buf.execute_command(r.command)
		end
	  end
	end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	require('lsp_extensions.workspace.diagnostic').handler, {
		signs = true,
		update_in_insert = true,
		underline = true,
		-- Enable virtual text only on Warning or above, override spacing to 2
		virtual_text = {
			spacing = 2,
		--	severity_limit = "Warning",
		},
	}
)

local servers = { 'jsonls', 'html', 'tsserver', 'cssls' }
for _, srv in pairs(servers) do
	M.setup(srv, {})
end

return M;
