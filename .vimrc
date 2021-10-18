call plug#begin('~/.vim/plugged')                           " plug stuff
Plug 'dense-analysis/ale'                                   " code inteligence
Plug 'rust-lang/rust.vim'                                   " rust
Plug 'justinmk/vim-dirvish'                                 " edit different files
Plug 'gruvbox-community/gruvbox'                            " colorscheme
Plug 'altercation/vim-colors-solarized'                     " colorscheme
Plug 'mhinz/vim-startify'                                   " splash screen
call plug#end()                                             " end plug stuff

"colorscheme gruvbox                                         " colorscheme
"set background=dark
"let g:gruvbox_invert_selection = 0                          " make highlightling better
colorscheme solarized
set background=dark

set nowrap                                                  " don't wrap text
set encoding=utf-8                                          " set the encoding
set number " relativenumber                                 " show numbers on relatively
set hlsearch                                                " show all search matches
set mouse=a                                                 " allow the mouse to click
set shiftwidth=4                                            " shift width
set tabstop=4                                               " tab stop
set softtabstop=4                                           " sets the number of columns for a tab
set shiftround                                              " always indent/outdent to the nearest tabstop
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

"let g:loaded_matchparen=1  " dont highlight other paren
let g:rustfmt_autosave = 1 " run rustfmt on save

" press things to do things
nnoremap SP :set invpaste<cr>
nnoremap tt :term<cr>
nnoremap + :set list!<cr>
vnoremap <silent>CP :w !xclip -selection clipboard<cr>
nnoremap _ :noh<cr>

" things to remember:
" vs, vertical split
" sp, horizontal split
"
" control direction to change splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap ZZ :vs<cr>
nnoremap zz :sp<cr>

function! Spaces(size)
    " update the current spaces to tabs before changing the size of a tab
    "let &l:shiftwidth=&shiftwidth
    "let &l:tabstop=&tabstop
    "let &l:softtabstop=&softtabstop
    "setlocal noexpandtab
    "retab!

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
    autocmd FileType html let &makeprg = 'firefox "%"'
    autocmd FileType sh let &makeprg = 'sh "%"'
    autocmd FileType cpp,cc,c,rust,javascript,java,python,haskell,tex,sh,html nnoremap CT :make<cr>
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

" startify "
" 'Most Recent Files' number
let g:startify_files_number           = 18

" Update session automatically as you exit vim
let g:startify_session_persistence    = 1

" Simplify the startify list to just recent files and sessions
let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ ]

" Fancy custom header
let g:startify_custom_header = [
  \ "  ",
  \ '   ╻ ╻   ╻   ┏┳┓',
  \ '   ┃┏┛   ┃   ┃┃┃',
  \ '   ┗┛    ╹   ╹ ╹',
  \ '   ',
  \ ]

" bar "
set laststatus=2
set statusline=%1*%f\ %y%=%2*<%{StatuslineMode()}>\ %l/%L:%c
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

