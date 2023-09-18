vim.cmd [[
	iabbr teh the
	iabbr adn and
	iabbr tehn then
	iabbr ehtn then
	iabbr anythign anything
	iabbr ti it
	iabbr hae have

	iabbr email@ oneofone@gmail.com
	iabbr name@ Ahmed W Mones
	iabbr mygh@ https://github.com/OneOfOne

	" qol
	iabbr if@ if () {<CR><TAB><CR>}<ESC>kkci(
	iabbr for@ for () {<CR><TAB><CR>}<ESC>==kkci(

	" ts/jsx
	iabbr clog@ console.log();<LEFT><LEFT>
	iabbr iife@ (async function() {<CR><TAB><CR>})();<ESC>kA
	iabbr try@ try {<CR><TAB>z<CR>} catch(e: any) {<CR><TAB>console.log(err);<CR>}<CR><ESC><ESC>?z<CR>x<ESC>i
]]
