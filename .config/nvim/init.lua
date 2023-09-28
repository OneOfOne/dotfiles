if not vim.uv then
	vim.uv = vim.loop
end

require('config.lazy')
require('config.abbr')
