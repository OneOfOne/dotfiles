-- vim.lsp.handlers['workspace/workspaceFolders'] = nil
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, max_width=80})]])
vim.lsp.log.set_level('error')
return {
	{
		'neovim/nvim-lspconfig',
		opts = {
			format_notify = true,
			diagnostics = {
				virtual_text = {
					source = 'always',
					prefix = 'icons',
				},
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
					-- enabled = false,
					settings = {
						vtsls = {
							complete_function_calls = false,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = false,
								},
							},
						},
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
					enabled = false,
					cmd = { 'tsgo', '--lsp', '--stdio' },
					filetypes = {
						'javascript',
						'javascriptreact',
						'javascript.jsx',
						'typescript',
						'typescriptreact',
						'typescript.tsx',
					},
					root_markers = {
						'tsconfig.json',
						'jsconfig.json',
						'package.json',
						'.git',
						'tsconfig.base.json',
					},
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
			opts.sources = vim.tbl_extend('force', opts.sources, { --override lazyvim's default sources
				nls.builtins.formatting.gofumpt,
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
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		opts = {
			ensure_installed = { 'css', 'scss' },
		},
	},
}
