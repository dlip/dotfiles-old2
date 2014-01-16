set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle '907th/vim-auto-save'
Bundle 'altercation/vim-colors-solarized'
Bundle 'dlip/vim-colemak'
Bundle 'dlip/vim-fugitive'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vividchalk'
Bundle 'tsaleh/vim-matchit'
Bundle 'Valloric/MatchTagAlways'
Bundle 'vim-ruby/vim-ruby'

filetype plugin indent on " Enable filetype-specific indenting and plugins

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

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

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

set background=dark
colorscheme solarized

" Set font according to system

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<space>"
let g:mapleader = "\<space>"

nnoremap <silent> <leader>b :CtrlPBuffer<cr>| " Search buffers
nnoremap <leader>e <C-W>j| " Move to split below
let g:EasyMotion_leader_key = '<Leader>,'
nnoremap <silent> <leader>gs :Gstatus<cr>| " Git status
nnoremap <leader>i <C-W>l| " Move to split right
nnoremap <leader>l gT|     " Move to tab left
nnoremap <silent> <leader>m :CtrlPMRUFiles<cr>| " Search most recent files
nnoremap <leader>n <C-W>h| " Move to split left
nnoremap <leader>u <C-W>k| " Move to split above
nnoremap <silent> <leader>v :e! ~/.vimrc<cr>| " Fast editing of the .vimrc
nnoremap <leader>y gt|     " Move to tab right
nnoremap <silent> <leader>/ :NERDTreeToggle<cr>
nnoremap <silent> <leader><leader> <C-^>| "Easily switch between this and last buffer

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tab
" Map tab to esc
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
inoremap <s-Tab> <Tab>
nnoremap <silent> <Tab> :noh<cr>

" Comfortable command
nnoremap ; :
vnoremap ; :

" Lazy save
nnoremap <silent>, :wa<cr>

" New colemak mappings
" Why did he map r to i?
" onoremap iw iw|      " inner word

if has("unix")
  if system('uname')=~'Darwin'
    vnoremap <C-x> "*dd|" Cut into clipboard       
    vnoremap <C-c> "*y| " Copy into clipboard 
    nnoremap <C-v> "*p| " Paste from clipboard      
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
let NERDTreeMapMenu='M'
let NERDTreeMapOpenExpl='' "Normally e
let NERDTreeMapUpdir='' "Normally u
let NERDTreeMapOpenSplit='' "Normally i
let NERDTreeMapQuit='q'
let g:NERDTreeDirArrows=0

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

" Emmet
let g:user_emmet_leader_key = '<c-e>'

" Autosave
let g:auto_save = 1  " enable AutoSave on Vim startup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd! bufwritepost .vimrc source ~/.vimrc "Autoload vimrc

