require('plugins')

require('plugins/treesetter')
require('plugins/telescope')
require('plugins/dap')

require('settings')
require('settings/ui')
require('settings/undo')

require('lsp')
require('lsp/gopls')

require('keymap') -- moved to postinit
vim.cmd([[ autocmd VimEnter * lua require('postinit') ]])
