vim.cmd [[
	iabbr teh the
	iabbr email@ oneofone@gmail.com
	iabbr name@ Ahmed W Mones
	iabbr mygh@ https://github.com/OneOfOne

	" qol
	iabbr iife@ (async function() {})();<C-o>4h<CR><CR><Up>
	iabbr if@ if() {<CR>}<Esc>%<Left><Left>i
	iabbr forof@ for(const v of z) {<CR><CR>}<Esc>?z<CR>xi
]]
