set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" file tree
Plugin 'scrooloose/nerdtree'

" fuzzy finder
Plugin 'ctrlpvim/ctrlp.vim'

" easily delete, change and add surroundings in pairs
Plugin 'tpope/vim-surround'

Plugin 'altercation/vim-colors-solarized'

" auto-commenter
Plugin 'scrooloose/nerdcommenter'

" js synxtax highlighting
Plugin 'jelera/vim-javascript-syntax'

" elm syntax highlighting and utils
Plugin 'elmcast/elm-vim'

" Ack search tool
Plugin 'mileszs/ack.vim'

" Seemless vim/tmux navigation
Plugin 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" set leader key to ,
let mapleader = ","

map \| :NERDTreeFind<CR>

" show hidden files in NERDTree
let NERDTreeShowHidden=1

" enable syntax highligting and set palette
set t_Co=256
syntax enable
set background=dark 

" show line numbers
set number

" ,/ to comment/uncomment lines
map <Leader>/ <Plug>NERDCommenterToggle

" ,a to search word under cursor
map <Leader>a "zyiw:Ack <C-r>z<CR>

" highlight search results
set hlsearch

" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab

" don't wrap long lines of text
set nowrap

" hitting space bar clears the current search highlighting
nmap <Space>  :let @/ = ""<CR>

" navigate between windows using ctrl + direction
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
