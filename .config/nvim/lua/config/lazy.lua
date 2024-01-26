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
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
	spec = {
		{
			'LazyVim/LazyVim',
			import = 'lazyvim.plugins',
		},
		{ import = 'lazyvim.plugins.extras.ui.edgy' },
		{ import = 'lazyvim.plugins.extras.ui.mini-animate' },
		{ import = 'lazyvim.plugins.extras.lsp.none-ls' },
		-- { import = 'lazyvim.plugins.extras.editor.aerial' },
		{ import = 'lazyvim.plugins.extras.test.core' },
		{ import = 'lazyvim.plugins.extras.dap.core' },
		{ import = 'lazyvim.plugins.extras.lang.typescript' },
		{ import = 'lazyvim.plugins.extras.lang.yaml' },
		{ import = 'lazyvim.plugins.extras.lang.go' },
		{ import = 'lazyvim.plugins.extras.lang.rust' },
		-- { import = 'lazyvim.plugins.extras.lang.json' }, -- this breaks with biome
		-- { import = 'lazyvim.plugins.extras.lang.python' },
		-- { import = 'lazyvim.plugins.extras.lang.clangd' },
		{ import = 'lazyvim.plugins.extras.coding.native_snippets' },
		{ import = 'lazyvim.plugins.extras.coding.yanky' },
		{ import = 'lazyvim.plugins.extras.coding.copilot' },
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
