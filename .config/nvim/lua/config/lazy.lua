local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.lazyvim_picker = 'telescope'
-- vim.g.lazyvim_picker = 'fzf'
require('lazy').setup({
	spec = {
		{ 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
		{ import = 'lazyvim.plugins.extras.coding.blink' },
		{ import = 'lazyvim.plugins.extras.lang.json' },
		{ import = 'lazyvim.plugins.extras.lang.typescript' },
		{ import = 'lazyvim.plugins.extras.lang.python' },
		{ import = 'lazyvim.plugins.extras.lang.yaml' },
		{ import = 'lazyvim.plugins.extras.lang.go' },
		{ import = 'lazyvim.plugins.extras.lang.rust' },
		-- { import = 'lazyvim.plugins.extras.lang.clangd' },

		{ import = 'lazyvim.plugins.extras.lsp.none-ls' },
		{ import = 'lazyvim.plugins.extras.test.core' },

		{ import = 'lazyvim.plugins.extras.dap.core' },

		{ import = 'lazyvim.plugins.extras.coding.mini-surround' },

		{ import = 'lazyvim.plugins.extras.ai.copilot', enabled = require('config.utils').is_local() },
		{ import = 'lazyvim.plugins.extras.ai.copilot-chat', enabled = require('config.utils').is_local() },

		{ import = 'lazyvim.plugins.extras.util.mini-hipatterns' },
		{ import = 'lazyvim.plugins.extras.util.dot' },

		{ import = 'lazyvim.plugins.extras.editor.navic' },
		{ import = 'lazyvim.plugins.extras.editor.telescope' },
		-- { import = 'lazyvim.plugins.extras.editor.fzf' },

		{ import = 'lazyvim.plugins.extras.ui.edgy' },
		{ import = 'lazyvim.plugins.extras.ui.mini-indentscope' },

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
