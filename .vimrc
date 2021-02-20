call plug#begin('~/.vim/plugged')   " plug stuff
Plug 'dense-analysis/ale'           " code inteligence
Plug 'rust-analyzer/rust-analyzer'  " rust inteligence
Plug 'pissmilk/vim_monochrome'      " colorscheme
call plug#end()

colorscheme monochrome      " colorscheme

set encoding=utf-8          " set the encoding
set number " relativenumber   " show numbers on relatively
set autochdir               " set current directory as working directory
set hlsearch                " show all search matches
set mouse=a                 " allow the mouse to click
set shiftwidth=4            " shift width
set tabstop=4               " tab stop
set expandtab               " use spaces as tabs

" press things to do things
nnoremap SP :set invpaste<cr>
nnoremap tt :term<cr>
nnoremap ct :!cargo run<cr>

" code that i copied from `salt rock lamp#0679` on discord
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

" set tab width and stuff to only 2 on webdev files
autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType css setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType js setlocal tabstop=2 shiftwidth=2 expandtab
