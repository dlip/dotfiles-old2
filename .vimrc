set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle '907th/vim-auto-save'
Bundle 'dlip/vim-colemak'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-vividchalk'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-fugitive'
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

colorscheme vividchalk

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<space>"
let g:mapleader = "\<space>"

nnoremap <silent> <leader>b :CtrlPBuffer<cr>| " Search buffers
nnoremap <leader>e <C-W>j| " Move to split below
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

" Clear search highlighting
nnoremap <silent><Esc> :noh<cr>
nnoremap <silent><C-c> :noh<cr>

" Comfortable command
nnoremap ; :
vnoremap ; :

" New colemak mappings
nnoremap cc yy|  " Double c to yank line
nnoremap <C-a> <C-v>| "Block selection to a key

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

" MatchTagAlways Options
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'eruby' : 1,
    \}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd! bufwritepost .vimrc source ~/.vimrc "Autoload vimrc

