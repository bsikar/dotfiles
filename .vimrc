call plug#begin('~/.vim/plugged')                           " plug stuff
Plug 'dense-analysis/ale'                                   " code inteligence
Plug 'rust-analyzer/rust-analyzer'                          " rust inteligence
"Plug 'bsikar/vim_monochrome'                                " colorscheme
Plug 'andreasvc/vim-256noir'                                " colorscheme
Plug 'rust-lang/rust.vim'                                   " rust
call plug#end()                                             " end plug stuff

"colorscheme monochrome                                      " colorscheme
colorcheme 256_noir                                          " colorscheme

set encoding=utf-8                                          " set the encoding
set number " relativenumber                                 " show numbers on relatively
set autochdir                                               " set current directory as working directory
set hlsearch                                                " show all search matches
set mouse=a                                                 " allow the mouse to click
set shiftwidth=4                                            " shift width
set tabstop=4                                               " tab stop
set softtabstop=4                                           " sets the number of columns for a tab
set autoindent                                              " auto indent
set smarttab                                                " insert spaces or tabs to go to the next indent
set expandtab                                               " use spaces as tabs
set fileformat=unix                                         " use unix files not dos
set wildmenu                                                " :help autocomplete
set wildmode=longest:full,full                              " :help autocomplete help
set ttyfast                                                 " helps with rendering large texts
set incsearch                                               " cool search thing
set ignorecase                                              " works with smart case to ignore caps when search is in lowercase
set smartcase                                               " ^^^
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·   " cool dots on the screen when S-Tab is pressed

let g:loaded_matchparen=1  " dont highlight other paren
let g:rustfmt_autosave = 1 " run rustfmt on save

" press things to do things
nnoremap SP :set invpaste<cr>
nnoremap tt :term<cr>
nnoremap <S-Tab> :set list!<cr>

function! Spaces(size)
    " update the current spaces to tabs before changing the size of a tab
    let &l:shiftwidth=&shiftwidth
    let &l:tabstop=&tabstop
    let &l:softtabstop=&softtabstop
    setlocal noexpandtab
    retab!

    " change tabs to spaces
    let &l:shiftwidth=a:size
    let &l:tabstop=a:size
    let &l:softtabstop=a:size
    setlocal smarttab
    setlocal expandtab
    retab!
endfunction

function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun

" remove trailing whitespace when saving any file
autocmd BufWritePre,FileWritePre,FileAppendPre,FilterWritePre *
  \ :call <SID>StripTrailingWhitespaces()

function! Unixify()
    if &l:fileformat != 'unix'
        setlocal fileformat=unix
        echo "making the file's format unix"
    endif
endfunction

augroup COMPILER
    autocmd!
    let s:args = ' "%" -o "%:r" && ./"%:r" && rm "%:r"'
    let s:java_args = ' "%" && java "%:r" && rm "%:r".class'
    let s:hs_args = ' "%" -o "%:r" && ./"%:r" && rm "%:r" "%:r".o "%:r".hi'
    let s:latex_args = ' "%" && rm "%:r".aux "%:r".log && evince "%:r".pdf && rm "%:r".pdf'
    autocmd FileType cpp,cc let &makeprg = 'clang++'.s:args
    autocmd FileType c let &makeprg = 'clang'.s:args
    autocmd FileType rust let &makeprg = 'rustc'.s:args
    autocmd FileType javascript let &makeprg = 'node "%"'
    autocmd FileType java let &makeprg = 'javac'.s:java_args
    autocmd FileType python let &makeprg = 'python3 "%"'
    autocmd FileType haskell let &makeprg = 'ghc'.s:hs_args
    autocmd FileType tex let &makeprg = 'pdflatex'.s:latex_args
    autocmd FileType cpp,cc,c,rust,javascript,java,python,haskell,tex nnoremap CT :make<cr>
    autocmd FileType rust nnoremap ct :!cargo run<cr>
    autocmd FileType rust nnoremap RF :RustFmt<cr>
augroup END

augroup INDENT
    autocmd!
    autocmd FileType html,css,javascript call Spaces(2)
    autocmd FileType c,cc,cpp,rust,java,python,haskell call Spaces(4)
augroup END

augroup MAKE_FILEFORMAT_UNIX
    autocmd!
    autocmd VimEnter * call Unixify()
augroup END

" bar "
set laststatus=2
set statusline=%1*%f\ %y%=%2*<%{StatuslineMode()}>\ %l/%L
hi User1 ctermfg=lightmagenta
hi User2 ctermfg=lightmagenta

function! StatuslineMode()
    let l:mode=mode()
    if l:mode==#"n"
        return "NORMAL"
    elseif l:mode==?"v"
        return "VISUAL"
    elseif l:mode==#"i"
        return "INSERT"
    elseif l:mode==#"R"
        return "REPLACE"
    elseif l:mode==?"s"
        return "SELECT"
    elseif l:mode==#"t"
        return "TERMINAL"
    elseif l:mode==#"c"
        return "COMMAND"
    elseif l:mode==#"!"
        return "SHELL"
    endif
endfunction
