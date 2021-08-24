local opts = {
	["completeUnimported"] = true,
	["formatting.gofumpt"] = true,
	["ui.diagnostic.staticcheck"] = true,
	["ui.diagnostic.analyses"] = {
		ST1000 = false,
		ST1003 = false,
		SA5001 = false,
		nilness = false,
		unusedwrite = false,
		unusedparams = false,
		fieldalignment = false,
		shadow = false,
		composites = false
	},
	["ui.codelenses"] = {
		generate = true,
		regenerate_cgo = true,
		test = true,
		vendor = true,
		tidy = true,
		upgrade_dependency = true,
		gc_details = true
	},
	["ui.diagnostic.annotations"] = {
		bounds = true,
		inline = true,
		escape = true,
		["nil"] = true
	},
	["ui.completion.usePlaceholders"] = true,
	["ui.navigation.importShortcut"] = "Definition",
	["ui.completion.completionBudget"] = "200ms",
	["ui.diagnostic.diagnosticsDelay"] = "100ms",
	["build.allowImplicitNetworkAccess"] = true,
	["build.directoryFilters"] = { "-node_modules", "-data" },
	["ui.completion.experimentalPostfixCompletions"] = true,
	["build.experimentalTemplateSupport"] = true,
	["build.experimentalPackageCacheKey"] = true
}

function go_org_imports(timeout_ms)
	local context = { source = { organizeImports = true } }
	vim.validate { context = { context, 't', true } }
	local params = vim.lsp.util.make_range_params()
	params.context = context

	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not result then return end
	result = result[1].result
	if not result then return end
	edit = result[1].edit
	vim.lsp.util.apply_workspace_edit(edit)
end

vim.api.nvim_command("au BufWritePre *.go lua go_org_imports(500)")
vim.api.nvim_command("au BufWritePre *.go lua vim.lsp.buf.formatting_sync()")

require('lsp').setup('gopls', opts)
