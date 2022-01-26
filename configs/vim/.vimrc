set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
" Plugins go here

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

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

" global find/replace inside working directory
function! FindReplace()
  " figure out which directory we're in
	let dir = expand('%:h')
  " ask for patterns
  call inputsave()
  let find = input('Pattern: ')
  call inputrestore()
  let replace = input('Replacement: ')
  call inputrestore()
  " are you sure?
  let confirm = input('WARNING: About to replace ' . find . ' with ' . replace . ' in ' . dir . '/**/* (y/n):')
  " clear echoed message
  :redraw
  if confirm == 'y'
    " find with rigrep (populate quickfix )
    :silent exe 'Rg ' . find
    " use cfdo to substitute on all quickfix files
    :silent exe 'cfdo %s/' . find . '/' . replace . '/g | update'
    " close quickfix window
    :silent exe 'cclose'
    :echom('Replaced ' . find . ' with ' . replace . ' in all files in ' . dir )
  else
    :echom('Find/Replace Aborted :(')
    return
  endif
endfunction

:nnoremap <Leader>fr :call FindReplace()<CR>
