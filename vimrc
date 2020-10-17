"" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

""" USER-INSTALLED PLUGIN
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'
Plugin 'yggdroot/indentline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'plasticboy/vim-markdown'
Plugin 'connorholyday/vim-snazzy'
Plugin 'mg979/vim-visual-multi'
Plugin 'triglav/vim-visual-increment'
"""

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"" End Vundle

"" Theme
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
try
    colorscheme snazzy
catch
endtry

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
set termencoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"" General
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

set number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally

if has("syntax")
 syntax on
endif

" Don't redraw while executing macros (good performance config)
set lazyredraw

"" Indent
set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set tabstop=4
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
autocmd FileType make setlocal noexpandtab

"" Advanced
set ruler	" Show row and column ruler information

set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
set whichwrap+=<,>,h,l

set cursorline  " highlight line with cursor

"" Remember last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"" Keymap
" Smart way to move between windows (<ctrl>j etc.):
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"Turn NerdTree on with ",nt"
map <Leader>nt <ESC>:NERDTree<CR>
let NERDTreeShowHidden=1
" let NERDTreeQuitOnOpen=1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|vendor$',
    \ 'file': '\v\.(exe|so|dll)$'
\ }


" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

"" Status line
" Always show the status line
set laststatus=2
" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"" IndentLine plugin
let g:indentLine_color_gui = '#385900'
let g:indentLine_color_term = 100
let g:indentLine_char = '¦'
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_enabled = 0
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'text', 'sh']
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
let g:indentLine_maxLines = 3000
nnoremap \il :IndentLinesToggle
