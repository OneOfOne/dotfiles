-- https://medium.com/@alpha2phi/modern-neovim-configuration-hacks-93b13283969f#6ab4
local map = vim.keymap.set

-- Auto Indent the Current Empty Line
map("n", "i", function()
	if #vim.fn.getline "." == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true })
-- https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/
vim.cmd [[
	" fix selection with mouse
	vmap <LeftRelease> "*ygv
	nmap <a-p> "*p
	nmap <a-P> "*P

	" old habits die hard
	imap <c-v> <esc>pi
	imap <c-a> <esc>ggVG

	map <leader>gl <cmd>OpenInGHFileLines<cr>
	map <leader>cw <leader>bd
	map <c-tab> <cmd>Telescope buffers theme=dropdown previewer=false<cr>
	nmap <c-p> <cmd>Legendary<cr>

	" movement
	map K 15k
	map J 15j

	map / /\v
	nmap ss :%s/\v
	nmap sds :.s/\v
	nmap sg :%g/\v
	nmap sdg :.g/\v

	nmap <leader>j *``cgn

	" remap toggle spell
	nmap <leader>us <cmd>setlocal spell!<cr>
]]
