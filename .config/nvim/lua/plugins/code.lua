vim.lsp.handlers['workspace/workspaceFolders'] = nil

vim.diagnostic.config({
	-- virtual_text = true,
	underline = true,
	signs = true,
	update_in_insert = false,
	severity_sort = true,
	float = true,
})

-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, max_width=80})]])

return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
		opts = {
			format_notify = true,

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
			flags = {
				debounce_text_changes = 350,
				-- allow_incremental_sync = true,
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
				biome = {},
			},
		},
	},
	{
		'nvimtools/none-ls.nvim',
		opts = function(_, opts)
			local nls = require('null-ls').builtins
			opts.sources = { --override lazyvim's default sources
				nls.code_actions.gitsigns,
				-- go
				nls.code_actions.gomodifytags,
				nls.code_actions.impl,
				nls.formatting.goimports,
				nls.formatting.gofumpt,
				-- nls.diagnostics.golangci_lint,
				-- ts
				-- nls.formatting.biome.with({
				-- 	filetypes = {
				-- 		'javascript',
				-- 		'javascriptreact',
				-- 		'json',
				-- 		'jsonc',
				-- 		'typescript',
				-- 		'typescriptreact',
				-- 		'css',
				-- 	},
				-- 	args = {
				-- 		'check',
				-- 		'--write',
				-- 		'--unsafe',
				-- 		'--formatter-enabled=true',
				-- 		'--organize-imports-enabled=true',
				-- 		'--skip-errors',
				-- 		'--stdin-file-path=$FILENAME',
				-- 	},
				-- }),
				-- other
				nls.formatting.stylua,
				nls.formatting.shfmt.with({
					filetypes = { 'sh', 'zsh' },
				}),
			}
			opts.debug = true
			return opts
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		opts = {
			ensure_installed = { 'vim', 'vimdoc' },
			textobjects = {
				swap = {
					enable = true,
					swap_next = {
						['[a'] = '@parameter.inner',
					},
					swap_previous = {
						[']a'] = '@parameter.inner',
					},
				},
				lsp_interop = {
					enable = true,
					border = 'none',
					floating_preview_opts = {},
					peek_definition_code = {
						['<leader>df'] = '@function.outer',
						['<leader>dF'] = '@class.outer',
					},
				},
			},
		},
	},
	-- { 'nvim-treesitter/nvim-treesitter-textobjects', enabled = false },
	{
		'f-person/git-blame.nvim',
		enabled = false,
		config = true,
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^5', -- Recommended
		ft = { 'rust' },
		opts = {
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set('n', '<leader>cR', function()
						vim.cmd.RustLsp('codeAction')
					end, { desc = 'Code Action', buffer = bufnr })
					vim.keymap.set('n', '<leader>dr', function()
						vim.cmd.RustLsp('debuggables')
					end, { desc = 'Rust Debuggables', buffer = bufnr })
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					['rust-analyzer'] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						-- Add clippy lints for Rust.
						checkOnSave = true,
						procMacro = {
							enable = true,
							ignored = {
								['async-trait'] = { 'async_trait' },
								['napi-derive'] = { 'napi' },
								['async-recursion'] = { 'async_recursion' },
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
			if vim.fn.executable('rust-analyzer') == 0 then
				LazyVim.error(
					'**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/',
					{ title = 'rustaceanvim' }
				)
			end
		end,
	},
}
