local dir = require('utils').real_cwd()
if dir then vim.cmd('cd ' .. dir) end
