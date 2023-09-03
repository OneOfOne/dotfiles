-- https://medium.com/@alpha2phi/modern-neovim-configuration-hacks-93b13283969f#6ab4
local map = vim.keymap.set

-- Auto Indent the Current Empty Line
map("n", "i", function()
	if #vim.fn.getline "." == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true, noremap = true })

-- https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/
vim.cmd [[
	" fix selection with mouse
	snoremap <LeftRelease> "*ygv
	nnoremap <a-p> "*p
	nnoremap <a-P> "*P

	" old habits die hard
	inoremap <c-v> <esc>pi
	inoremap <c-a> <esc>ggVG

	nnoremap <leader>gl <cmd>OpenInGHFileLines<cr>
	nnoremap <leader>cw <leader>bd
	nnoremap <c-tab> <cmd>Telescope buffers theme=dropdown previewer=false<cr>

	" movement
	nnoremap K 15k
	nnoremap J 15j

	nnoremap / /\v
	nnoremap ss :%s/\/
	nnoremap sds :.s/\v
	nnoremap sg :%g/\v
	nnoremap sdg :.g/\v

	nnoremap <leader>j *``cgn

	nnoremap vv :normal! v<cr>

	" remap toggle spell
	nnoremap <leader>us <cmd>setlocal spell!<cr>
]]
