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

require('lsp').setup('gopls', opts)
