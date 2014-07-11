if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Keyboard Layout
NeoBundle 'dlip/vim-colemak'

" Search
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'rking/ag.vim'

" Motions
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-unimpaired'

" Snippets
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'

" File types
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'ecomba/vim-ruby-refactoring'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'lepture/vim-jinja'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'saltstack/salt-vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'Valloric/MatchTagAlways'

" Colors
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaky/vim-colors-github'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'tpope/vim-vividchalk'

" Version control
NeoBundle 'dlip/vim-fugitive'

" Text objects
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-surround'

" Comments
NeoBundle 'scrooloose/nerdcommenter'

" File browsing
NeoBundle 'scrooloose/nerdtree'

" Syntax checking
NeoBundle 'scrooloose/syntastic'

" Misc
NeoBundle '907th/vim-auto-save'
NeoBundle 'joonty/vdebug'
NeoBundle 'maksimr/vim-jsbeautify'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on           " Enable syntax highlighting
set so=7            " Set 7 lines to the curors - when moving vertical..
set history=300     " Sets how many lines of history VIM has to remember
set autoread        " Set to auto read when a file is changed from the outside
set wildmenu        " Turn on WiLd menu
set wildmode=list:longest,full
set ruler           " Always show current position
set cmdheight=2     " The commandbar height
set ignorecase      " Ignore case when searching
set hlsearch        " Highlight search things
set hid             " Change buffer - without saving
set incsearch       " Make search act like search in modern browsers
set magic           " Set magic on, for regular expressions
set showmatch       " Show matching bracets when text indicator is over them
set mat=1           " How many tenths of a second to blink
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set backspace=indent,eol,start
set nostartofline  " Avoid cursor moving to start of line when switching buffers
set nofoldenable    " disable folding

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

if has("gui_running")
  set guioptions+=LlRrb
  set guioptions-=LlRrb
  set guioptions-=T
  set guioptions-=m
  set t_Co=256
  set lines=40 columns=130
  if has('mac')
    set gfn=Consolas:h11
  elseif has('win32')
    set gfn=Consolas:h11
  elseif has('unix')
    set gfn=Monospace\ 10
  endif
endif

set background=light
colorscheme github

" Set font according to system

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<space>"
let g:mapleader = "\<space>"

nnoremap <silent> <leader>b :CtrlPBuffer<cr>| " Search buffers
nnoremap <leader>e <C-W>j| " Move to split below
let g:EasyMotion_leader_key = '<Leader>,'
nnoremap <silent> <leader>gg :Gstatus<cr>| " Git status
nnoremap <silent> <leader>gp :Git push<cr>
nnoremap <silent> <leader>gl :Git pull --rebase<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <leader>i <C-W>l| " Move to split right
nnoremap <leader>l gT|     " Move to tab left
nnoremap <silent> <leader>m :CtrlPMRUFiles<cr>| " Search most recent files
nnoremap <silent> <leader>p :CtrlPCurWD<cr>| " Search working dir
"nnoremap <silent> <leader>p :Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer bookmark<cr>
nnoremap <leader>n <C-W>h| " Move to split left
nnoremap <leader>u <C-W>k| " Move to split above
nnoremap <silent> <leader>v :e! ~/.vimrc<cr>| " Fast editing of the .vimrc
nnoremap <leader>y gt|     " Move to tab right
nnoremap <silent> <leader>/ :NERDTreeToggle<cr>
nnoremap <silent> <leader>? :NERDTreeFind<cr>
nnoremap <silent> <leader><leader> <C-^>| "Easily switch between this and last buffer

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tab
" Map tab to esc
"vnoremap <Tab> <Esc>gV
"onoremap <Tab> <Esc>
"inoremap <Tab> <ESC>`^
"inoremap <s-Tab> <Tab>
"nnoremap <tab> :silent !osascript ~/bin/refreshchrome.applescript 'http://localhost:3000/'<cr>:redraw!<cr>
nnoremap <silent> <C-l> :noh<cr>:redraw!<cr>
set virtualedit=onemore
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
vnoremap <Enter> <Esc>gV
inoremap <Enter> <ESC>`^
nnoremap <Enter> i<Enter><ESC>
nnoremap <S-Enter> O<ESC>

" Comfortable command
nnoremap ; :
vnoremap ; :

" Lazy save
nnoremap <silent>, :wa<cr>

" New colemak mappings
" Why did he map r to i?
" onoremap iw iw|      " inner word
nnoremap J Jx

" Change next word to end of word in visual mode
"vnoremap y e
"vnoremap Y E
"vnoremap l b
"vnoremap L B

"Select all text in current buffer
nnoremap <Leader>a ggVG

if has("unix")
  if system('uname')=~'Darwin'
    vnoremap <C-x> "*dd|" Cut into clipboard
    vnoremap <C-c> "*y| " Copy into clipboard
    imap <C-V> <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<CR>
  else
    vnoremap <C-x> "+dd|" Cut into clipboard
    vnoremap <C-c> "+y| " Copy into clipboard
    nnoremap <C-v> "+p| " Paste from clipboard
  endif
elseif has('win32')
  vnoremap <C-x> "+dd|" Cut into clipboard
  vnoremap <C-c> "+y| " Copy into clipboard
  nnoremap <C-v> "+p| " Paste from clipboard
endif

"NerdTree Options
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMapMenu='M'
let g:NERDTreeMapOpenExpl='' "Normally e
let g:NERDTreeMapUpdir='' "Normally u
let g:NERDTreeMapOpenSplit='' "Normally i
let g:NERDTreeMapQuit='q'
let g:NERDTreeDirArrows=0
let g:NERDTreeMapHelp='H'
let g:NERDTreeMapUpdirKeepOpen='' " U
let g:NERDTreeMapPreviewSplit='' " G

" MatchTagAlways Options
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'eruby' : 1,
    \}

" Surround.vim
let g:surround_no_mappings=1
nmap ds  <Plug>Dsurround
nmap ws  <Plug>Csurround
nmap cs  <Plug>Ysurround
nmap cS  <Plug>YSurround
nmap css <Plug>Yssurround
nmap cSs <Plug>YSsurround
nmap cSS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround
imap <C-S> <Plug>Isurround
imap <C-G>s <Plug>Isurround
imap <C-G>S <Plug>ISurround
let b:surround_{char2nr('=')} = "<%= \r %>"
let b:surround_{char2nr('-')} = "<% \r %>"

" Emmet
let g:user_emmet_leader_key = '<C-o>'
imap <C-e> <C-o>,

" Autosave
let g:auto_save = 1  " enable AutoSave on Vim startup

" Multiple cursors
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
"let g:multi_cursor_quit_key='<Tab>'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"ctrlp
let g:ctrlp_working_path_mode = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd! bufwritepost .vimrc source ~/.vimrc "Autoload vimrc

"Fix annoying remapping of i
au FileType eruby,ruby xunmap <buffer> iM
au FileType eruby,ruby ounmap <buffer> iM
au FileType eruby,ruby xunmap <buffer> im
au FileType eruby,ruby ounmap <buffer> im

au FileType qf nnoremap <buffer> <Enter> <Enter>
