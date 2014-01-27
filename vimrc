runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
filetype plugin indent on
set nu
set laststatus=2
set incsearch
set hlsearch

" Clipboard
if has('windows')
    set clipboard=unnamed
elseif has('unix')
    set clipboard=unnamedplus
endif

" Tab
set tabstop=4
set shiftwidth=4
set expandtab

" Key bindings
let mapleader = ","
"nn <silent> <F11> :<c-u>MRU<cr>
nn <silent> <F11> :MRU<cr>
nn <silent> <F10> :Gstatus<cr>
nmap <silent> <leader>ee :e ~/.vimrc<cr>

" Autocmds
autocmd BufEnter * silent! lcd %:p:h

" Web source indenting
autocmd FileType xml,javascript,html,css,php set sw=2
autocmd FileType xml,javascript,html,css,php set ts=2
autocmd FileType xml,javascript,html,css,php set sts=2
:let g:PHP_default_indenting = 1

" Cscope
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set csto=0
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    " Keys
    nmap <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" Markdown
let g:vim_markdown_folding_disabled=1
