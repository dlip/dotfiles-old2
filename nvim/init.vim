" #Core Options
syntax enable       " Enable syntax highlighting
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
set mouse=
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

Plug 'dlip/vim-unimpaired'

Plug '907th/vim-auto-save'
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0

Plug 'scrooloose/nerdcommenter'| ", { 'on': 'NERDCommenterToggle' }

Plug 'rhysd/nyaovim-markdown-preview'| ", { 'for': 'markdown' }
let g:markdown_preview_auto = 1
let g:markdown_preview_eager = 1

Plug 'rking/ag.vim'
let g:ag_apply_qmappings=0

Plug 'taiansu/nerdtree-ag'

Plug 'benekastah/neomake'
let g:neomake_verbose = 3

Plug 'sheerun/vim-polyglot'

" ##Colors
Plug 'jonathanfilip/vim-lucius'
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
let g:solarized_termtrans = 1

Plug 'vimwiki/vimwiki'| ", { 'on': ['VimwikiIndex', 'VimwikiMakeDiaryNote', 'VimwikiDiaryIndex', 'CalendarH'] }
let g:vimwiki_list = [{'path': '~/Dropbox/Draft/', 'syntax': 'markdown', 'ext': '.md'},
                      \{'path': '~/Dropbox/Draft.old/', 'syntax': 'markdown', 'ext': '.md', 'index': '0-personal'},
                      \{'path': '~/Dropbox/Draft.old/', 'syntax': 'markdown', 'ext': '.md', 'index': '1-work'}]

let g:vimwiki_table_mappings=0
let g:vimwiki_markdown_link_include_extension=1

Plug 'mattn/calendar-vim'| ", { 'on': 'CalendarH' }

Plug 'dbeniamine/todo.txt-vim'
let g:Todo_txt_do_not_map=1
" Sort todo by (first) context
noremap <silent><localleader>sc :call todo#HierarchicalSort('@', '', 1)<CR>
noremap <silent><localleader>scp :call todo#HierarchicalSort('@', '+', 1)<CR>
" Sort todo by (first) project
noremap <silent><localleader>sp :call todo#HierarchicalSort('+', '',1)<CR>
noremap <silent><localleader>spc :call todo#HierarchicalSort('+', '@',1)<CR>
" Sort tasks {{{2
nnoremap <script> <silent> <buffer> <LocalLeader>s :call todo#Sort()<CR>
nnoremap <script> <silent> <buffer> <LocalLeader>s@ :sort /.\{-}\ze@/ <CR>
nnoremap <script> <silent> <buffer> <LocalLeader>s+ :sort /.\{-}\ze+/ <CR>
" Priorities {{{2
noremap <script> <silent> <buffer> <LocalLeader>u :call todo#PrioritizeIncrease()<CR>
noremap <script> <silent> <buffer> <LocalLeader>e :call todo#PrioritizeDecrease()<CR>
noremap <script> <silent> <buffer> <LocalLeader>a :call todo#PrioritizeAdd('A')<CR>
noremap <script> <silent> <buffer> <LocalLeader>b :call todo#PrioritizeAdd('B')<CR>
noremap <script> <silent> <buffer> <LocalLeader>c :call todo#PrioritizeAdd('C')<CR>
" Insert date {{{2
inoremap <script> <silent> <buffer> d<Tab> <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <script> <silent> <buffer> u: due:<C-R>=strftime("%Y-%m-%d")<CR>
inoremap <script> <silent> <buffer> DUE: DUE:<C-R>=strftime("%Y-%m-%d")<CR>
noremap <script> <silent> <buffer> <localleader>d :call todo#PrependDate()<CR>
" Mark done {{{2
noremap <script> <silent> <buffer> <localleader>x :call todo#ToggleMarkAsDone('')<CR>
" Mark done {{{2
noremap <script> <silent> <buffer> <localleader>C :call todo#ToggleMarkAsDone('Cancelled')<CR>
" Mark all done {{{2
noremap <script> <silent> <buffer> <localleader>X :call todo#MarkAllAsDone()<CR>
" Remove completed {{{2
nnoremap <script> <silent> <buffer> <localleader>D :call todo#RemoveCompleted()<CR>
" Sort by due: date {{{1
nnoremap <script> <silent> <buffer> <localleader>sd :call todo#SortDue()<CR>

Plug 'ervandew/supertab'

Plug 'honza/vim-snippets'

call plug#end()

" #Colors
set background=dark
colorscheme solarized

" #Shortcuts

" Tab as Esc
"nnoremap <silent> <Tab> :nohl<CR>:redraw!<CR><Esc>
"vnoremap <Tab> <Esc>gV
"onoremap <Tab> <Esc>
"inoremap <Tab> <Esc>`^

nnoremap <silent> <Tab> :nohl<CR>:redraw!<CR><Esc>
" Backtick as Esc
vnoremap ` <Esc>gV
onoremap ` <Esc>
inoremap ` <Esc>`^
nnoremap ` gi`

" qp as escape
vnoremap qp <Esc>gV
onoremap qp <Esc>
inoremap qp <Esc>`^

" Comfortable command
nnoremap ; :
vnoremap ; :

map <leader>c <plug>NERDCommenterToggle
nmap <leader>wC <Plug>CalendarH
nmap <leader>wc <Plug>CalendarV
nnoremap <leader>e <C-W>j| " Move to split below
nnoremap <leader>i <C-W>l| " Move to split right
nnoremap <leader>n <C-W>h| " Move to split left
nnoremap <leader>u <C-W>k| " Move to split above
nnoremap <silent> <C-l> :noh<cr>:redraw!<cr>
nnoremap <silent> <leader>$ :%s/\s\+$//<CR>| "Strip trailing whitespace
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
nnoremap <silent> <leader>/ :NERDTreeToggle<cr>
nnoremap <silent> <leader>v :e! $MYVIMRC<CR>
