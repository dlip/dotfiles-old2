" #Core Options
syntax enable           " Enable syntax highlighting
set so=7            " Set 7 lines to the curors - when moving vertical..
set history=300     " Sets how many lines of history VIM has to remember
set autoread        " Set to auto read when a file is changed from the outside
set wildmenu        " Turn on WiLd menu
set wildmode=list:longest,full
set ruler           " Always show current position
set ignorecase      " Ignore case when searchin" g
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
" set mouse=
set clipboard=unnamedplus

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
let g:NERDTreeDirArrows=1
let g:NERDTreeIgnore=['\.git','\.hg']
let g:NERDTreeMapMenu='M'
let g:NERDTreeMapOpenExpl='' "Normally e
let g:NERDTreeMapUpdir='<BS>' "Normally u
let g:NERDTreeMapOpenSplit='s' "Normally i
let g:NERDTreeMapOpenVSplit='v'
let g:NERDTreeMapQuit='q'
let g:NERDTreeMapHelp='H'
let g:NERDTreeMapUpdirKeepOpen='' " U
let g:NERDTreeMapPreviewSplit='' " G

Plug 'tpope/vim-fugitive'
autocmd BufReadPost fugitive://* set bufhidden=delete
let g:fugitive_no_maps=1

Plug 'tpope/vim-unimpaired'

Plug '907th/vim-auto-save'
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0

Plug 'tomtom/tcomment_vim'

Plug 'rhysd/nyaovim-markdown-preview'
let g:markdown_preview_auto = 1
let g:markdown_preview_eager = 1

" ##Colors
Plug 'jonathanfilip/vim-lucius'

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/Dropbox/Draft/', 'syntax': 'markdown', 'ext': '.md'},
                      \{'path': '~/Dropbox/Draft.old/', 'syntax': 'markdown', 'ext': '.md', 'index': '0-personal'},
                      \{'path': '~/Dropbox/Draft.old/', 'syntax': 'markdown', 'ext': '.md', 'index': '1-work'}]

let g:vimwiki_table_mappings=0
let g:vimwiki_markdown_link_include_extension=1

Plug 'mattn/calendar-vim'
" nnoremap <silent> <leader>C :Calendar<CR>
" nnoremap <silent> <Leader>t :VimwikiMakeDiaryNote<CR>

call plug#end()

" #Colors
set background=dark
colorscheme lucius

" #Shortcuts

" Tab as Esc
nnoremap <silent> <Tab> :nohl<CR>:redraw!<CR><Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^


" Comfortable command
nnoremap ; :
vnoremap ; :

nmap <leader>wC <Plug>CalendarH
nmap <leader>wc <Plug>CalendarV
nnoremap <leader>e <C-W>j| " Move to split below
nnoremap <leader>i <C-W>l| " Move to split right
nnoremap <leader>n <C-W>h| " Move to split left
nnoremap <leader>u <C-W>k| " Move to split above
nnoremap <silent> <C-l> :noh<cr>:redraw!<cr>
nnoremap <silent> <leader>$ :%s/\s\+$//<CR>| "Strip trailing whitespace
nnoremap <silent> <leader>/ :TComment<cr>
nnoremap <silent> <leader><leader> <C-^>| "Easily switch between this and last buffer
nnoremap <silent> <leader>? :NERDTreeFind<cr>
nnoremap <silent> <leader>V :so $MYVIMRC<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gg :Gstatus<CR>
nnoremap <silent> <leader>gl :Git pull --rebase<cr>
nnoremap <silent> <leader>go :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gremove<CR>
nnoremap <silent> <leader>gsp :Git stash pop<CR>
nnoremap <silent> <leader>gss :Git stash<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>t :NERDTreeToggle<cr>
nnoremap <silent> <leader>v :e! $MYVIMRC<CR>
vnoremap <silent> <leader>/ :TComment<cr>
