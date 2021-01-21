call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'rust-analyzer/rust-analyzer'
Plug 'pissmilk/vim_monochrome'
call plug#end()

colorscheme monochrome

set encoding=utf-8
set number relativenumber
set autochdir
set hlsearch
set mouse=a
set shiftwidth=4
set tabstop=4
set expandtab

nnoremap SP :set paste<CR>
nnoremap tt :term<CR>
nnoremap CT :!cc "%" -o program && ./program && rm program<CR>
nnoremap j gj
nnoremap k gk
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype html set nospell
autocmd Filetype css setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype css set nospell
autocmd Filetype js setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype js set nospell
