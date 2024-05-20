local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
	spec = {
		{ 'LazyVim/LazyVim', import = 'lazyvim.plugins' },

		{ import = 'lazyvim.plugins.extras.lang.json' },
		-- { import = 'lazyvim.plugins.extras.lang.typescript' },
		{ import = 'lazyvim.plugins.extras.lang.python' },
		{ import = 'lazyvim.plugins.extras.lang.yaml' },
		{ import = 'lazyvim.plugins.extras.lang.go' },
		{ import = 'lazyvim.plugins.extras.lang.rust' },

		{ import = 'lazyvim.plugins.extras.lsp.none-ls' },
		{ import = 'lazyvim.plugins.extras.test.core' },
		{ import = 'lazyvim.plugins.extras.dap.core' },

		{ import = 'lazyvim.plugins.extras.coding.mini-surround' },
		{ import = 'lazyvim.plugins.extras.coding.copilot', enabled = require('config.utils').is_local() },

		{ import = 'lazyvim.plugins.extras.util.mini-hipatterns' },
		{ import = 'lazyvim.plugins.extras.util.dot' },

		{ import = 'lazyvim.plugins.extras.editor.navic' },
		{ import = 'lazyvim.plugins.extras.editor.trouble-v3' },
		{ import = 'lazyvim.plugins.extras.editor.mini-diff' },

		{ import = 'lazyvim.plugins.extras.ui.edgy' },
		{ import = 'lazyvim.plugins.extras.ui.mini-indentscope' },
		-- { import = 'lazyvim.plugins.extras.ui.treesitter-rewrite' },

		-- { import = 'lazyvim.plugins.extras.lang.clangd' },

		{ import = 'plugins' },
	},
	defaults = {
		lazy = false,
		version = false,
		-- version = '*', -- try installing the latest stable version for plugins that support semver
	},
	ui = {
		border = 'rounded',
	},
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				'gzip',
				'matchit',
				'matchparen',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
			},
		},
	},
})
