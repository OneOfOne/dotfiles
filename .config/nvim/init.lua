require("plugins")
-- require('plugins/treesetter')
require("plugins/telescope")
require("plugins/dap")

require("settings")
require("settings/ui")
require("settings/git")

-- require('lsp')
-- require('lsp/gopls')

require("keymap")

function _G.wait_for_plugins()
	local dir = require("utils").real_cwd()
	if dir then vim.cmd("cd " .. dir) end
end

-- run after all plugins are loaded / unloaded
vim.cmd([[ autocmd VimEnter * lua wait_for_plugins() ]])
