if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

let mapleader = "\<space>"
let g:mapleader = "\<space>"

if has("win32")
  set shell=cmd
  set shellcmdflag=/c
endif

" functions {{{
  function! s:get_cache_dir(suffix) "{{{
    return resolve(expand('~/.vim/.cache/' . a:suffix))
  endfunction "}}}
"}}}

" Keyboard Layout
NeoBundle 'dlip/vim-colemak'

" Search
NeoBundle 'Shougo/vimproc', { 'build': {
  \   'windows': 'make -f make_mingw32.mak',
  \   'cygwin': 'make -f make_cygwin.mak',
  \   'mac': 'make -f make_mac.mak',
  \   'unix': 'make -f make_unix.mak',
\ } }

NeoBundle 'Shougo/unite.vim' "{{{
  let bundle = neobundle#get('unite.vim')
  function! bundle.hooks.on_source(bundle)
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#set_profile('files', 'smartcase', 1)
    call unite#custom#source('line,outline','matchers','matcher_fuzzy')
  endfunction

  function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <esc> <plug>(unite_exit)
  endfunction
  autocmd FileType unite call s:unite_settings()

  let g:unite_data_directory=s:get_cache_dir('unite')
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable=1
  let g:unite_source_rec_max_cache_files=50000
  let g:unite_prompt='» '
  nmap <space> [unite]
  nnoremap [unite] <nop>

  nnoremap <silent> [unite]p :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr><c-u>
  nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr><c-u>
  nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=recent file_mru<cr>
  nnoremap <silent> [unite]w :<C-u>Unite -buffer-name=gitgrep vcs_grep/git<cr>
  nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
  nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
  nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
  nnoremap <silent> [unite]r :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
  nnoremap <silent> [unite]' :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
  nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
"}}}
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'rking/ag.vim'

" Motions
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-unimpaired'

" Snippets
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

" Version control
"NeoBundle 'dlip/vim-fugitive'
NeoBundle 'tpope/vim-fugitive' "{{{
  nnoremap <silent> <leader>gg :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Git pull --rebase<cr>
  nnoremap <silent> <leader>go :Glog<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gr :Gremove<CR>
  autocmd BufReadPost fugitive://* set bufhidden=delete
"}}}

" Text objects
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-surround'

" Comments
NeoBundle 'scrooloose/nerdcommenter'

" File browsing
NeoBundleLazy 'scrooloose/nerdtree', {'autoload':{'commands':['NERDTreeToggle','NERDTreeFind']}} "{{{
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=1
  let NERDTreeShowLineNumbers=0
  let NERDTreeChDirMode=0
  let NERDTreeShowBookmarks=0
  let NERDTreeDirArrows=0
  let NERDTreeIgnore=['\.git','\.hg']
  let NERDTreeBookmarksFile=s:get_cache_dir('NERDTreeBookmarks')
  let NERDTreeMapMenu='M'
  let NERDTreeMapOpenExpl='' "Normally e
  let NERDTreeMapUpdir='' "Normally u
  let NERDTreeMapOpenSplit='' "Normally i
  let NERDTreeMapQuit='q'
  let NERDTreeMapHelp='H'
  let NERDTreeMapUpdirKeepOpen='' " U
  let NERDTreeMapPreviewSplit='' " G
  nnoremap <silent> <leader>/ :NERDTreeToggle<cr>
  nnoremap <silent> <leader>? :NERDTreeFind<cr>
"}}}

" Syntax checking
NeoBundle 'scrooloose/syntastic'

" Misc
NeoBundle '907th/vim-auto-save'
NeoBundle 'joonty/vdebug'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'mattn/calendar-vim'
NeoBundle 'vimwiki/vimwiki' "{{{
  let g:vimwiki_list = [{'path': '~/Dropbox/Wiki/', 'ext': '.md', 'path_html': '~/Dropbox/Wiki_html/'}]
  nnoremap <silent> <leader>C :Calendar<CR>
"}}}


" Color schemes
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'croaky/vim-colors-github'
NeoBundle 'jonathanfilip/vim-lucius'
"NeoBundle 'tpope/vim-vividchalk'
"NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'tomasr/molokai'
"NeoBundle 'chriskempson/vim-tomorrow-theme'
"NeoBundle 'chriskempson/base16-vim'
"NeoBundle 'w0ng/vim-hybrid'
"NeoBundle 'sjl/badwolf'
"NeoBundle 'zeis/vim-kolor' "{{{
  "let g:kolor_underlined=1
""}}}

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

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

set background=dark
colorscheme lucius

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


" Set font according to system
if has("win32")
  set guifont=Consolas:h12 
  set guifontwide=MingLiU:h12 "For windows to display mixed character sets
  set encoding=utf-8
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>e <C-W>j| " Move to split below
let g:EasyMotion_leader_key = '<Leader>,'
nnoremap <leader>i <C-W>l| " Move to split right
"nnoremap <leader>l gT|     " Move to tab left
nnoremap <leader>n <C-W>h| " Move to split left
nnoremap <leader>u <C-W>k| " Move to split above
nnoremap <silent> <leader>v :e! ~/.vimrc<cr>| " Fast editing of the .vimrc
"nnoremap <leader>y gt|     " Move to tab right
nnoremap <silent> <leader><leader> <C-^>| "Easily switch between this and last buffer

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map Enter to esc
nnoremap <silent> <C-l> :noh<cr>:redraw!<cr>
set virtualedit=onemore
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
"vnoremap <Enter> <Esc>gV
"inoremap <Enter> <ESC>`^
"nnoremap <Enter> i<Enter><ESC>
"nnoremap <S-Enter> O<ESC>

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

"ctrlp
"let g:ctrlp_working_path_mode = 0

" My todo
"o thing
"o stuff
"  o subtask
"  o another
"odont match
"  odont match
nnoremap <silent> <leader>t :vimgrep /^\(\s*\)\=o\s/ ./**/*.md <CR> :copen <CR>
nnoremap <silent> <leader>1 :vimgrep /^\(\s*\)\=o\s1/ ./**/*.md <CR> :copen <CR>
nnoremap <silent> <leader>2 :vimgrep /^\(\s*\)\=o\s2/ ./**/*.md <CR> :copen <CR>
nnoremap <silent> <leader>3 :vimgrep /^\(\s*\)\=o\s3/ ./**/*.md <CR> :copen <CR>
nnoremap <silent> <leader>4 :vimgrep /^\(\s*\)\=o\s4/ ./**/*.md <CR> :copen <CR>
nnoremap <silent> <leader>5 :vimgrep /^\(\s*\)\=o\s5/ ./**/*.md <CR> :copen <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd! bufwritepost .vimrc source ~/.vimrc "Autoload vimrc

"Fix annoying remapping of i
"au FileType eruby,ruby xunmap <buffer> iM
"au FileType eruby,ruby ounmap <buffer> iM
"au FileType eruby,ruby xunmap <buffer> im
"au FileType eruby,ruby ounmap <buffer> im

au FileType qf nnoremap <buffer> <Enter> <Enter>
