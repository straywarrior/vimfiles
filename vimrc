runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

colorscheme molokai
let g:molokai_original = 1
if has("gui_running")
    set guioptions-=m
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=t
    set guioptions-=T
    set gcr=a:block-blinkon0
    set cursorline
    if has('unix')
        set guifont=DroidSansMono\ 11
    elseif has('windows')
        set guifont=Consolas:h11
    endif
endif

if has("gui_running")
    "let g:airline_powerline_fonts = 1
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    " unicode symbols
    let g:airline_left_sep = '»'
    let g:airline_right_sep = '«'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.whitespace = 'Ξ'
endif

" Indent Guide
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Folding
set foldmethod=syntax
set nofoldenable

syntax on
filetype plugin indent on
set nu
set laststatus=2
set incsearch
set hlsearch

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" Clipboard
if has('unix')
    "set clipboard=unnamedplus
elseif has('windows')
    set clipboard=unnamed
endif

" Tab
set tabstop=4
set shiftwidth=4
set expandtab

" Key bindings
let mapleader = ";"
nn <silent> <F10> :Gstatus<cr>
if has('unix')
    nmap <silent> <leader>ee :tabnew ~/.vim/vimrc<cr>
    nmap <silent> <leader>es :source ~/.vim/vimrc<cr>
elseif has('windows')
    nmap <silent> <leader>ee :tabnew ~/vimfiles/vimrc<cr>
    nmap <silent> <leader>es :tabnew ~/vimfiles/vimrc<cr>
endif
vnoremap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>t :tabnew

" Unite
nnoremap <silent> <C-P><C-P> :Unite -start-insert file<cr>
nnoremap <silent> <C-P><C-B> :Unite tab -start-insert<cr>
nnoremap <silent> <C-P><C-R> :Unite buffer -start-insert<cr>
nnoremap <silent> <F11> :Unite neomru/file<cr>

" Unite-global
" let g:unite_source_gtags_result_option = "ctags-x"
nnoremap <silent> <C-P>c :Unite gtags/context<cr>
nnoremap <silent> <C-P>r :Unite gtags/ref<cr>
nnoremap <silent> <C-P>d :Unite gtags/def<cr>
nnoremap <silent> <C-P>g :Unite gtags/grep<cr>
nnoremap <silent> <C-P>l :Unite gtags/completion<cr>

" Autocmds
autocmd BufEnter * silent! lcd %:p:h

" Web source indenting
autocmd FileType xml,javascript,html,css,php set sw=2
autocmd FileType xml,javascript,html,css,php set ts=2
autocmd FileType xml,javascript,html,css,php set sts=2
:let g:PHP_default_indenting = 1

" Session
function! SetupSession()
    if ! exists('b:VIM_SESSION_FILE')
        let d = expand('%:p:h')
        let f = ''
        while d != '/'
            if  filereadable(d . '/.session.vim') || isdirectory(d . '/.git')
                let b:VIM_SESSION_FILE = d . '/.session.vim'
                break
            endif
            let d = fnamemodify(d, ':h')
        endwhile
    endif
endfunction
function! SaveSession()
    if exists('b:VIM_SESSION_FILE')
        execute 'mksession! ' . b:VIM_SESSION_FILE
    else
        mksession! ~/.vim_session.vim
    endif
endfunction
function! LoadSession()
    if exists('b:VIM_SESSION_FILE')
        execute 'source ' . b:VIM_SESSION_FILE
    else
        source ~/.vim_session.vim
    endif
endfunction

nmap <Leader>m :call SaveSession()<CR>
nmap <Leader>l :call LoadSession()<CR>
autocmd BufEnter * call SetupSession()

" Cscope
function! SetupCscope()
    if has("cscope") && ! exists('w:cscope_setup')
        let w:cscope_setup = 1
        set cscopequickfix=s-,c-,d-,i-,t-,e-
        set csto=0
        " add any database in current directory
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
        nmap <C-_> :tab cstag <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>s :tab cs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>g :tab cs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>c :tab cs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>t :tab cs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>e :tab cs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-_>f :tab cs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-_>i :tab cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-_>d :tab cs find d <C-R>=expand("<cword>")<CR><CR>
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
