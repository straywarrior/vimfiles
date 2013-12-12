runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
filetype plugin indent on
set nu
set laststatus=2

" Tab
set tabstop=4
set shiftwidth=4
set expandtab

" Key bindings
let mapleader = ","
"nn <silent> <F11> :<c-u>MRU<cr>
nn <silent> <F11> :MRU<cr>
nn <silent> <F10> :Gstatus<cr>

" Autocmds
autocmd BufEnter * silent! lcd %:p:h
