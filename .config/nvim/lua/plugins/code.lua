-- vim.lsp.handlers['workspace/workspaceFolders'] = nil
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, max_width=80})]])

return {
	{
		'neovim/nvim-lspconfig',
		opts = {
			format_notify = true,
			diagnostics = {
				virtual_text = {
					source = 'always',
				},
				-- virtual_text = false,
				-- virtual_lines = false,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = 'rounded',
					source = 'always',
				},
				-- signs = true,
				-- virtual_text = {
				-- 	source = 'always',
				-- 	severity = {
				-- 		max = vim.diagnostic.severity.WARN,
				-- 	},
				-- },
				-- virtual_lines = {
				-- 	current_line = true,
				-- 	severity = {
				-- 		min = vim.diagnostic.severity.ERROR,
				-- 	},
				-- },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = '', -- or other icon of your choice here, this is just what my config has:
						[vim.diagnostic.severity.WARN] = '',
						[vim.diagnostic.severity.INFO] = '',
						[vim.diagnostic.severity.HINT] = '󰌵',
					},
					numhl = {
						[vim.diagnostic.severity.WARN] = 'WarningMsg',
						[vim.diagnostic.severity.ERROR] = 'ErrorMsg',
						[vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
						[vim.diagnostic.severity.HINT] = 'DiagnosticHint',
					},
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
					commands = {
						Format = {
							function() end,
						},
					},
					json = {
						format = {
							enable = false,
						},
					},
				},
				vtsls = {
					settings = {
						complete_function_calls = false,
						vtsls = {
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = false,
								},
							},
						},
					},
				},
				html = {},
				biome = {},
				-- harper_ls = {
				-- 	settings = {
				-- 		['harper-ls'] = {
				-- 			userDictPath = vim.fn.stdpath('config') .. '/spell/en.utf-8.add',
				-- 		},
				-- 	},
				-- },
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
		-- branch = 'main',
		opts = {
			ensure_installed = { 'css', 'scss', 'latex' },
			-- incremental_selection = {
			-- 	keymaps = {
			-- 		init_selection = '<leader>vv',
			-- 		node_incremental = '+',
			-- 		node_decremental = '_',
			-- 	},
			-- },
			textobjects = {
				swap = {
					enable = true,
					swap_previous = {
						[']a'] = '@parameter.inner',
					},
					swap_next = {
						['[a'] = '@parameter.inner',
					},
				},
				lsp_interop = {
					enable = true,
					border = 'rounded',
					floating_preview_opts = {},
					peek_definition_code = {
						['<leader>df'] = '@function.outer',
						['<leader>dF'] = '@class.outer',
					},
				},
			},
		},
	},
	{
		'daliusd/incr.nvim',
		opts = {
			-- incr_key = '+', -- increment selection key
			-- decr_key = '-', -- decrement selection key
		},
	},
}
