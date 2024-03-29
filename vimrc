runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

let g:username="StrayWarrior"
let g:email="i@straywarrior.com"

if !has('gui_running')
    let g:solarized_termtrans=1
endif
" let g:solarized_termcolors=256
set background=dark
colorscheme solarized
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
    set lines=512
    set columns=512
    if has('unix')
        set guifont=DroidSansMono\ 11
    elseif has('windows')
        " Nerd Font has some problems for gVim
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
    endif
endif

" Vim-Airline settings
if has("gui_running")
    let g:airline_powerline_fonts = 1
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
else
    if $TERM_PROGRAM == 'iTerm.app'
        let g:airline_powerline_fonts = 1
    elseif !empty($WT_SESSION)
        let g:airline_powerline_fonts = 1
    endif
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Indent Guide
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
set cino=N-s,i0,g0

" Folding
set foldmethod=syntax
set nofoldenable

syntax on
filetype plugin indent on
set nu
set laststatus=2
set incsearch
set hlsearch

set encoding=utf-8
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
    nmap <silent> <leader>es :source ~/vimfiles/vimrc<cr>
endif
vnoremap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>x :x<CR>
nmap <Leader>t :tabnew
nmap <Leader>s :split
nmap <Leader>v :vsplit
nmap <Leader>do :Dox<CR>

" Unite
" nnoremap <silent> <C-P><C-P> :Unite -start-insert file<cr>
nnoremap <silent> <C-P><C-P> :Unite file_rec/async -start-insert<cr>
nnoremap <silent> <C-P><C-B> :Unite tab -start-insert<cr>
nnoremap <silent> <C-P><C-R> :Unite buffer -start-insert<cr>

" Unite-global
" let g:unite_source_gtags_result_option = "ctags-x"
nnoremap <silent> <C-P>c :Unite gtags/context<cr>
nnoremap <silent> <C-P>r :Unite gtags/ref<cr>
nnoremap <silent> <C-P>d :Unite gtags/def<cr>
nnoremap <silent> <C-P>g :Unite gtags/grep<cr><C-R><C-W>
nnoremap <silent> <C-P>l :Unite gtags/completion<cr>

" Autocmds
if ! &diff
    autocmd BufEnter * silent! lcd %:p:h
endif
au BufRead,BufNewFile *.cu,*.cuh set filetype=cuda
au BufRead,BufNewFile SConstruct,SConscript set filetype=python

" Web source indenting
autocmd FileType yaml,yml,tex set ts=2
autocmd FileType yaml,yml,tex set sw=2
autocmd FileType yaml,yml,tex set sts=2
autocmd FileType xml,javascript,html,jinja,css,php set sw=2
autocmd FileType xml,javascript,html,jinja,css,php set ts=2
autocmd FileType xml,javascript,html,jinja,css,php set sts=2
let g:PHP_default_indenting = 0

" Go source indenting
autocmd FileType go set noexpandtab

" Scala source indenting
autocmd FileType scala set ts=2
autocmd FileType scala set sw=2
autocmd FileType scala set sts=2

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

if has('unix')
    nmap <Leader>m :call SaveSession()<CR>
    nmap <Leader>l :call LoadSession()<CR>
    autocmd BufEnter * call SetupSession()
endif

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

if has('unix')
autocmd FileType c,cpp call SetupCscope()
endif

autocmd FileType c,cpp,python,vim set tw=79

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

" Template settings
if has('windows')
    let g:templates_name_prefix=".vim-template"
endif


" Self-defined commands
if ! exists(":Rmtw")
    command Rmtw :%s/\s\+$// | :w
endif

set complete-=i
