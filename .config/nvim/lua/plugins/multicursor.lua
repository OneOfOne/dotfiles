return {
	"mg979/vim-visual-multi",
	branch = "master",
	event = "VeryLazy",
	init = function()
		vim.keymap.set('n', '<C-d>', '<Plug>(VM-Find-Under)', { noremap = false })
	end,
}
