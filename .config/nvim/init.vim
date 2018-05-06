set encoding=utf-8
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo=
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set t_Co=256

set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/dein')
	call dein#begin('~/.config/nvim/dein')

	call dein#add('Shougo/dein.vim')
	call dein#add('Shougo/deoplete.nvim')
	call dein#add('joshdick/onedark.vim')

	call dein#end()
	call dein#save_state()
endif

syntax on
filetype indent on
filetype plugin indent on
colorscheme onedark

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

filetype plugin on

if &term=="xterm"
		 set t_Co=8
		 set t_Sb=[4%dm
		 set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

set number
set wildmenu
set showcmd  
set cursorline
set lazyredraw
set showmatch 

set noexpandtab
set tabstop=4
set shiftwidth=4

