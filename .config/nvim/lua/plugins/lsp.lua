-- vim.lsp.handlers['workspace/workspaceFolders'] = nil
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, max_width=80})]])
vim.lsp.log.set_level('error')

return {
	{
		'neovim/nvim-lspconfig',
		opts = {
			format_notify = true,
			diagnostics = {
				-- virtual_text = {
				-- 	source = 'always',
				-- 	prefix = 'icons',
				-- },
				virtual_text = false,
				underline = true,
				float = {
					border = 'rounded',
					source = 'always',
				},
			},
			inlay_hints = {
				enabled = false,
			},
			codelens = {
				enabled = true,
			},
			folds = {
				enabled = false,
			},
			showMessage = {
				messageActionItem = {
					additionalPropertiesSupport = true,
				},
			},
			format = {
				timeout_ms = 1000,
			},
			servers = {
				jsonls = {
					-- commands = {
					-- 	Format = {
					-- 		function() end,
					-- 	},
					-- },
					json = {
						format = {
							enable = false,
						},
					},
				},
				vtsls = {
					enabled = false,
					settings = {
						vtsls = {
							complete_function_calls = false,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = false,
								},
							},
						},
						typescript = { preferences = { useAliasesForRenames = false } },
					},
				},
				gopls = {
					-- cmd = { 'gopls', '-logfile=/tmp/gopls.log', '-rpc.trace' },
					settings = {
						gopls = {
							completeFunctionCalls = false,
							usePlaceholders = false,
							analyses = {
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
								fillreturns = false,
							},
							staticcheck = true,
							semanticTokens = true,
						},
					},
				},
				tsgo = {
					-- enabled = false,
					-- cmd = { 'tsgo', '--lsp', '--stdio' },
					-- filetypes = {
					-- 	'javascript',
					-- 	'javascriptreact',
					-- 	'javascript.jsx',
					-- 	'typescript',
					-- 	'typescriptreact',
					-- 	'typescript.tsx',
					-- },
					-- root_markers = {
					-- 	'tsconfig.json',
					-- 	'jsconfig.json',
					-- 	'package.json',
					-- 	'.git',
					-- 	'tsconfig.base.json',
					-- },
				},
				html = {},
				biome = {},
			},
		},
	},
	{
		'nvimtools/none-ls.nvim',
		-- enabled = false,
		optional = true,
		opts = function(_, opts)
			local nls = require('null-ls').builtins
			-- gofumpt doesn't follow gopls's disabled analysises
			opts.sources = vim.tbl_filter(function(source)
				return source ~= nls.formatting.gofumpt
			end, opts.sources)

			opts.sources = vim.tbl_extend('force', opts.sources, { --override lazyvim's default sources
				nls.diagnostics.golangci_lint,
				-- nls.formatting.gofumpt,
				-- ts
				nls.formatting.biome.with({
					args = {
						'check',
						'--write',
						'--unsafe',
						'--formatter-enabled=true',
						'--assist-enabled=true',
						'--stdin-file-path=$FILENAME',
					},
				}),
				--
				-- other
				nls.formatting.shfmt.with({
					filetypes = { 'sh', 'zsh' },
				}),
				nls.code_actions.gitsigns,
			})
			opts.debug = false
			return opts
		end,
	},
	{
		'rachartier/tiny-inline-diagnostic.nvim',
		event = 'LspAttach',
		priority = 1000,
		-- enabled = false,
		opts = {
			options = {
				show_source = {
					enabled = true, -- Enable showing source names
					if_many = false, -- Only show source if multiple sources exist for the same diagnostic
				},
				multilines = {
					enabled = true, -- Enable support for multiline diagnostic messages
					always_show = true, -- Always show messages on all lines of multiline diagnostics
					trim_whitespaces = false, -- Remove leading/trailing whitespace from each line
					tabstop = 4, -- Number of spaces per tab when expanding tabs
				},
				show_all_diags_on_cursorline = true,
				break_line = {
					enabled = true, -- Enable automatic line breaking
					after = 60, -- Number of characters before inserting a line break
				},
			},
		},
	},
}
