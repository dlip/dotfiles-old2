" #Core Options
syntax enable           " Enable syntax highlighting
set so=7            " Set 7 lines to the curors - when moving vertical..
set history=300     " Sets how many lines of history VIM has to remember
set autoread        " Set to auto read when a file is changed from the outside
set wildmenu        " Turn on WiLd menu
set wildmode=list:longest,full
set ruler           " Always show current position
set ignorecase      " Ignore case when searching
set hlsearch        " Highlight search things
set hid             " Change buffer - without saving
set incsearch       " Make search act like search in modern browsers
set magic           " Set magic on, for regular expressions
set showmatch       " Show matching bracets when text indicator is over them
set mat=1           " How many tenths of a second to blink
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set backspace=indent,eol,start
set nostartofline  " Avoid cursor moving to start of line when switching buffers
set nowrap
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" Tab as Esc
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^

" Leader
let mapleader = "\<space>"
let g:mapleader = "\<space>"

let maplocalleader = ","
let g:maplocalleader = ","

" #Plugins
call plug#begin('~/.nvim/plugged')

Plug 'dlip/vim-colemak'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let g:NERDTreeShowHidden=0
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowLineNumbers=0
let g:NERDTreeChDirMode=0
let g:NERDTreeShowBookmarks=0
let g:NERDTreeDirArrows=0
let g:NERDTreeIgnore=['\.git','\.hg']
let g:NERDTreeMapMenu='M'
let g:NERDTreeMapOpenExpl='' "Normally e
let g:NERDTreeMapUpdir='' "Normally u
let g:NERDTreeMapOpenSplit='' "Normally i
let g:NERDTreeMapQuit='q'
let g:NERDTreeMapHelp='H'
let g:NERDTreeMapUpdirKeepOpen='' " U
let g:NERDTreeMapPreviewSplit='' " G

Plug 'tpope/vim-fugitive'
autocmd BufReadPost fugitive://* set bufhidden=delete
let g:fugitive_no_maps=1

Plug '907th/vim-auto-save'
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0

Plug 'tomtom/tcomment_vim'
let g:tcommentMapLeaderOp1 = "\<leader>"

Plug 'altercation/vim-colors-solarized'
set background=light
colorscheme solarized

call plug#end()

" Shortcuts
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gg :Gstatus<CR>
nnoremap <silent> <leader>gl :Git pull --rebase<cr>
nnoremap <silent> <leader>go :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gremove<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader><leader> <C-^>| "Easily switch between this and last buffer
nnoremap <silent> <leader>V :so $MYVIMRC<CR>
nnoremap <silent> <leader>v :e! $MYVIMRC<CR>
nnoremap <silent> <leader>/ :NERDTreeToggle<cr>
nnoremap <silent> <leader>? :NERDTreeFind<cr>
