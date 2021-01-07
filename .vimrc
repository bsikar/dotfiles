call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'rust-analyzer/rust-analyzer'
Plug 'pissmilk/vim_monochrome'
call plug#end()

colorscheme monochrome

setlocal spell
set encoding=utf-8
set spelllang=en_us
set number relativenumber
set autochdir
set hlsearch
set mouse=a
set shiftwidth=0
set expandtab

nnoremap SP :set paste<CR>
nnoremap tt :term<CR>
nnoremap CT :!cc "%" -o program && ./program && rm program<CR>
nnoremap j gj
nnoremap k gk
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

autocmd Filetype html setlocal tabstop=2
autocmd Filetype html set nospell
autocmd Filetype css setlocal tabstop=2
autocmd Filetype css set nospell
autocmd Filetype js setlocal tabstop=2
autocmd Filetype js set nospell
autocmd Filetype c setlocal tabstop=4
autocmd Filetype c set nospell
autocmd Filetype cpp setlocal tabstop=4
autocmd Filetype cpp set nospell
autocmd Filetype cc setlocal tabstop=4
autocmd Filetype cc set nospell
autocmd Filetype d setlocal tabstop=4
autocmd Filetype d set nospell
autocmd Filetype rs setlocal tabstop=4
autocmd Filetype rs set nospell
