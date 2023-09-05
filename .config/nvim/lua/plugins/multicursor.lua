return {
	"mg979/vim-visual-multi",
	branch = "master",
	event = "VeryLazy",
	init = function()
		vim.keymap.set('', '<c-d>', '<Plug>(VM-Find-Under)', { noremap = true })
	end,
}
