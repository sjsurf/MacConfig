"行号
:set number

" 语法高亮
syntax on

"编码方式
set encoding=utf-8

"256 色
set t_Co=256

set autoindent

set tabstop=2
set shiftwidth=4

set cursorline

"高亮对应的符号
set showmatch

set hlsearch
set incsearch

set ignorecase
set smartcase

"set spell spelllang=en_us

set noswapfile

set undofile
set undodir=~/.vimUndoDir

set visualbell

set history=500

set listchars=tab:»■,trail:■

set wildmenu
set wildmode=longest:list,full

set backspace=indent,eol,start

"python
let python_highlight_all=1
au Filetype python set tabstop=4
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99

set nocompatible
filetype off

"Self Addreviations
:iabbrev @@ sjsurf@gmail.com

"Self Key Mpping
let mapleader = '~'

inoremap <esc> <nop>
inoremap jk <esc>

vnoremap <leader>' <esc>`<i'<esc>`>ei'<esc>
vnoremap <leader>" <esc>`<i"<esc>`>ei"<esc>

nnoremap H ^
nnoremap L g_
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel

"NERDTree
nnoremap <leader>N :NERDTreeFocus<CR> :wincmd p<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required

Plugin 'gmarik/Vundle.vim'
Plugin 'preservim/nerdtree'

"let g:python3_host_prog=/usr/local/bin/python3

Plugin 'Chiel92/vim-autoformat'

nnoremap <F6> :Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
