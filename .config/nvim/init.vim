set nocompatible
let vimDir = fnamemodify(expand($MYVIMRC), ':h')
let vimplug_exists = vimDir . '/autoload/plug.vim'
set shell=zsh

if !filereadable(vimplug_exists)
	if !executable("curl")
		echoerr "You have to install curl or first install vim-plug yourself!"
		execute "q!"
	endif

	echo "Installing Vim-Plug..."
	echo ""
	silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	let g:not_finish_vimplug = "yes"

	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Required:
call plug#begin(vimDir . '/plugged')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'Shougo/neosnippet.vim'
	Plug 'Shougo/neosnippet-snippets'
	Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
	Plug 'itchyny/lightline.vim'
	Plug 'jiangmiao/auto-pairs'
	Plug 'arcticicestudio/nord-vim'
	Plug 'preservim/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

let g:deoplete#enable_at_startup = 1

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

"" Map leader to ,
let mapleader=','

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
"set autochdir                           " Your working directory will always be the same as your working directory
set inccommand=nosplit                  " preview of substitutes

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

" splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right

" You can't stop me
cmap w!! w !sudo tee %

colorscheme nord
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

let g:NERDTreeGitStatusIndicatorMapCustom = {
	\ "Modified"  : "✹",
	\ "Staged"    : "✚",
	\ "Untracked" : "✭",
	\ "Renamed"   : "➜",
	\ "Unmerged"  : "═",
	\ "Deleted"   : "✖",
	\ "Dirty"     : "✗",
	\ "Clean"     : "✔︎",
	\ 'Ignored'   : '☒',
	\ "Unknown"   : "?"
	\ }
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" go

call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_updatetime = 500
let g:go_fillstruct_mode = 'gopls'
let g:go_metalinter_command = 'gopls'
let g:go_term_reuse = 1
let g:go_term_enabled = 1
"let g:go_debug = ["lsp"]

python3 << EOF
import vim
import json

gopls_cfg = json.loads("""{
	"formatting.gofumpt": true,
	"ui.diagnostic.staticcheck": true,
	"ui.diagnostic.analyses": {
		"ST1000": false,
		"ST1003": false,
		"SA5001": false,
		"nilness": true,
		"unusedwrite": true,
		"fieldalignment": true,
		"shadow": false,
		"composites": false
	},
	"ui.codelenses": {
		"generate": true,
		"regenerate_cgo": true,
		"test": true,
		"vendor": true,
		"tidy": true,
		"upgrade_dependency": true,
		"gc_details": true
	},
	"ui.diagnostic.annotations": {
		"bounds": true,
		"inline": true,
		"escape": true,
		"nil": true
	},

	"ui.completion.usePlaceholders": true,
	"ui.navigation.importShortcut": "Definition",
	"ui.completion.completionBudget": "500ms",

	"build.allowImplicitNetworkAccess": true,
	"build.directoryFilters": ["-node_modules", "-data"],

	"ui.diagnostic.experimentalDiagnosticsDelay": "300ms",
	"ui.completion.experimentalPostfixCompletions": true,
	"build.experimentalTemplateSupport": true,
	"build.experimentalPackageCacheKey": true
}""")
EOF

let g:go_gopls_settings = py3eval("gopls_cfg")
