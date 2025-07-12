set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
" Plugins go here

" git plugin
Plug 'tpope/vim-fugitive'

" easily delete, change and add surroundings in pairs
" change
"   'hello world' to [hello world]: cs']
"   'hello world' to hello world: ds'
"   hello world to (hello) world: ysiw)
"   hello world to (hello world): yss)
Plug 'tpope/vim-surround'

" change case of a selection
" convert to
"   snake_case: crs
"   MixedCase:  crm
"   camelCase:  crc
"   UPPER_CASE: cru
"   dash-case:  cr-
"   dot.case:   cr.
"   space case: cr<space>
"   Title Case: crt
Plug 'https://github.com/tpope/vim-abolish'

" make dot-repeat work with other tpope plugins
Plug 'https://github.com/tpope/vim-repeat'

" file tree
Plug 'scrooloose/nerdtree'

" fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'altercation/vim-colors-solarized'

" auto-commenter
Plug 'scrooloose/nerdcommenter'


" RipGrep (Rg) search tool
Plug 'jremmen/vim-ripgrep'

" Seemless vim/tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" Writable search aka global find and replace
Plug 'AndrewRadev/writable_search.vim'

"javascript Plugins
" js synxtax highlighting
Plug 'jelera/vim-javascript-syntax'

"elm Plugins
" elm syntax highlighting and utils
Plug 'elmcast/elm-vim'

" nix syntax highlighting
Plug 'LnL7/vim-nix'

" idris syntax highlighting
Plug 'idris-hackers/idris-vim'

" kotlin syntax highlighting
Plug 'udalov/kotlin-vim'

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

" BANDAID, compatibility issues with vim 9
" keep the bottom menu restricted to 1 line
let g:NERDTreeMinimalMenu=1

"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""

" set some nice defaults for folding
" fold based on language
set foldmethod=syntax

" fold inner most block cursor is on
" don't automatically fold everything when opening a file
set foldlevel=99

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

" ,l copy current file path to clipboard
map <leader>l :let @+=expand("%")<CR>

" ,n copy current file path and line number to clipboard
map <leader>n :let @+=fnamemodify(expand("%"), ":~:.") . ":" . line(".")<CR>

" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab

" don't wrap long lines of text
set nowrap

" highlight search results
set hlsearch

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

command! -nargs=? Ws WritableSearch <args>

" update ctags on file save
"au BufWritePost * silent! ![[ -f ~/.ctags.d/generate_ctags.sh ]] && source ~/.ctags.d/generate_ctags.sh &

" default regex engine does not play well with typescript
" so set regex engine to type '2'
set re=2

