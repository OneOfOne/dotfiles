local lsp = require('lspconfig')
local utils = require('utils')
local m = utils.map
local g = vim.g
local cmd = vim.cmd

vim.g.coq_settings = { auto_start = 'shut-up' }
local coq = require('coq')

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


function org_imports(wait_ms)
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

cmd([[
	autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require('lsp').do_hints()
	autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics{focusable=false}
	autocmd BufWritePre * :silent! lua org_imports(3000)
	autocmd BufWritePre * :silent! lua vim.lsp.buf.formatting_sync()
	set shortmess+=c
]])

local M = {}

function M.setup(name, init_opts)
	local coq = require('coq')
	lsp[name].setup(coq.lsp_ensure_capabilities({
		init_options = init_opts,
		flags = {
			onlyAnalyzeProjectsWithOpenFiles = true,
			suggestFromUnimportedLibraries = true,
			closingLabels = true,
			debounce_text_changes = 200,
		}
	}))
end

function M.do_hints()
	require('lsp_extensions').inlay_hints({
		prefix = '',
		highlight = "Comment",
		enabled = { "TypeHint", "ChainingHint", "ParameterHint" }
	})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
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
