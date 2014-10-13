runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
filetype plugin indent on
set nu
set laststatus=2
set incsearch
set hlsearch

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

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
nn <silent> <F10> :Gstatus<cr>
nmap <silent> <leader>ee :e ~/.vim/vimrc<cr>

" Unite
nnoremap <C-P> :Unite -start-insert file<cr>

" Autocmds
autocmd BufEnter * silent! lcd %:p:h

" Web source indenting
autocmd FileType xml,javascript,html,css,php set sw=2
autocmd FileType xml,javascript,html,css,php set ts=2
autocmd FileType xml,javascript,html,css,php set sts=2
:let g:PHP_default_indenting = 1

" Cscope
function! SetupCscope()
    if has("cscope") && ! exists('w:cscope_setup')
        let w:cscope_setup = 1
        set cscopequickfix=s-,c-,d-,i-,t-,e-
        set csto=0
        " add any database in current directory
        lcd %:p:h
        let d = expand('%:p:h')
        let f = ''
        while d != '/'
            if  filereadable(d . '/cscope.out')
                let f = d . '/cscope.out'
                break
            endif
            let d = fnamemodify(d, ':h')
        endwhile
        if f != ''
            execute 'cs add ' . f
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
endfunction
autocmd FileType c,cpp call SetupCscope()

" Markdown
let g:vim_markdown_folding_disabled=1

" Taglist
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1

nmap <silent> <leader>tt :TlistToggle<CR>

" Xmledit
let g:xmledit_enable_html = 1

" Slimv
" let g:paredit_mode=0
" let g:slimv_swank_scheme = '! urxvtc -e guile -l ~/.vim/bundle/slimv/slime/start-swank.lisp &'

" Gitgutter
let g:gitgutter_enabled = 0
nmap <silent> <leader>tg :GitGutterToggle<CR>
