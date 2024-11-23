vim.lsp.handlers['workspace/workspaceFolders'] = nil

-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, max_width=80})]])

return {
	{
		'neovim/nvim-lspconfig',
		priority = 10,
		opts = function(_, opts)
			local ret = vim.tbl_deep_extend('force', opts, {
				diagnostics = {
					virtual_text = false,
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
					float = true,
				},
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
					biome = {},
					html = {},
				},
			})
			return ret
		end,
	},
	{
		'rachartier/tiny-inline-diagnostic.nvim',
		-- enabled = false,
		event = 'LspAttach', -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		opts = {
			options = {
				-- Show the source of the diagnostic.
				show_source = true,
				multiline = true,
			},
		},
	},
	{
		'nvimtools/none-ls.nvim',
		opts = function(_, opts)
			local nls = require('null-ls').builtins
			opts.sources = { --override lazyvim's default sources
				-- nls.code_actions.gitsigns,
				-- go
				nls.code_actions.gomodifytags,
				nls.code_actions.impl,
				nls.formatting.goimports,
				nls.formatting.gofumpt,
				-- nls.diagnostics.golangci_lint,
				-- ts
				nls.formatting.biome.with({
					args = {
						'check',
						'--write',
						'--unsafe',
						'--formatter-enabled=true',
						'--organize-imports-enabled=true',
						'--skip-errors',
						'--stdin-file-path=$FILENAME',
					},
				}),
				-- other
				nls.formatting.stylua,
				nls.formatting.shfmt.with({
					filetypes = { 'sh', 'zsh' },
				}),
			}
			return opts
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		opts = {
			-- ensure_installed = { 'vimdoc', 'luadoc', 'vim', 'lua', 'markdown', 'query' },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
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
