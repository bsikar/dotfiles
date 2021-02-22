" MIT License
" 
" Copyright (c) 2021 Brighton Sikarskie
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

call plug#begin('~/.vim/plugged')                           " plug stuff
Plug 'dense-analysis/ale'                                   " code inteligence
Plug 'rust-analyzer/rust-analyzer'                          " rust inteligence
Plug 'pissmilk/vim_monochrome'                              " colorscheme
call plug#end()                                             " end plug stuff

colorscheme monochrome                                      " colorscheme

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
set showmatch                                               " when searching for a word it shows the closest match
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·   " cool dots on the screen when S-Tab is pressed

" press things to do things
nnoremap SP :set invpaste<cr>
nnoremap tt :term<cr>
nnoremap ct :!cargo run<cr>
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
    retab
endfunction

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
    autocmd FileType cpp,cc let &makeprg = 'clang++'.s:args
    autocmd FileType c let &makeprg = 'clang'.s:args
    autocmd FileType rust let &makeprg = 'rustc'.s:args
    autocmd FileType javascript let &makeprg = 'node "%"'
    autocmd FileType java let &makeprg = 'javac'.s:java_args
    autocmd FileType python let &makeprg = 'python3 "%"'
    autocmd FileType haskell let &makeprg = 'ghc'.s:hs_args
    autocmd FileType cpp,cc,c,rust,javascript,java,python,haskell nnoremap CT <cmd>make<cr>
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
