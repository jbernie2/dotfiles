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
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" easily delete, change and add surroundings in pairs
Plugin 'tpope/vim-surround'

Plugin 'altercation/vim-colors-solarized'

" auto-commenter
Plugin 'scrooloose/nerdcommenter'

" js synxtax highlighting
Plugin 'jelera/vim-javascript-syntax'

" elm syntax highlighting and utils
Plugin 'elmcast/elm-vim'

" RipGrep (Rg) search tool
Plugin 'jremmen/vim-ripgrep'

" Seemless vim/tmux navigation
Plugin 'christoomey/vim-tmux-navigator'

" Send command to tmux from vim
Plugin 'preservim/vimux'

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

"""""""""""""""""""""""""""""""""""
"""""  NERDTREE Configuration """""
"""""""""""""""""""""""""""""""""""

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
