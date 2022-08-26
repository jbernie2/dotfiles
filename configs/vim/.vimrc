set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
" Plugins go here

" git plugin
Plug 'tpope/vim-fugitive'

" file tree
Plug 'scrooloose/nerdtree'

" fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" easily delete, change and add surroundings in pairs
Plug 'tpope/vim-surround'

Plug 'altercation/vim-colors-solarized'

" auto-commenter
Plug 'scrooloose/nerdcommenter'

" js synxtax highlighting
Plug 'jelera/vim-javascript-syntax'

" elm syntax highlighting and utils
Plug 'elmcast/elm-vim'

" RipGrep (Rg) search tool
Plug 'jremmen/vim-ripgrep'

" Seemless vim/tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" Send command to tmux from vim
Plug 'preservim/vimux'

" Writable search aka global find and replace
Plug 'AndrewRadev/writable_search.vim'

" All of your Plugins must be added before the following line
call plug#end()

" set leader key to ,
let mapleader = ","

"""""""""""""""""""""""""""""""""""
"""""  NERDTREE Configuration """""
"""""""""""""""""""""""""""""""""""

" make '|' command smart
" if in the NerdTree window, close
" if in a file, open, and go to that file in NerdTree
" if in an empty buffer, open NerdTree at root directory
function! NERDTreeToggleInCurDir()
  if (&filetype=="nerdtree")
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction

map \| :call NERDTreeToggleInCurDir()<CR>

" close vim if :q is used and the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" show hidden files in NERDTree
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""

" enable syntax highligting and set palette
set t_Co=256
syntax enable
set background=dark 

" show line numbers
set number

" ,/ to comment/uncomment lines
map <Leader>/ <Plug>NERDCommenterToggle

" ,a to search word under cursor
map <Leader>a "zyiw:Rg --hidden --glob "!.git/*" <C-r>z<CR>

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

" ctrl+p to open fuzzy finder
map <C-p> :FZF<CR>

" use system clipboard for yanking text
set clipboard=unnamed

" run a command in adjacent tmux window
map <Leader>vp :VimuxPromptCommand<CR>

command! -nargs=? Ws WritableSearch <args>
