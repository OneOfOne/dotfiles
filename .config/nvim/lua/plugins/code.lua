vim.lsp.handlers['workspace/workspaceFolders'] = nil

-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, max_width=80})]])

return {
	{
		'neovim/nvim-lspconfig',
		opts = function(_, opts)
			local ret = vim.tbl_deep_extend('force', opts, {
				diagnostics = {
					virtual_text = false,
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
					float = {
						border = 'rounded',
						source = 'always',
					},
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
					-- biome = {},
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
						'--organize-imports-enabled=true',
						'--skip-errors',
						'--stdin-file-path=$FILENAME',
					},
				}),
				-- other
				nls.formatting.shfmt.with({
					filetypes = { 'sh', 'zsh' },
				}),
			})
			opts.debug = false
			return opts
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		opts = {
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
}
