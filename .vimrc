syntax on
set ruler
set nofoldenable

set spelllang=en_au
set spellfile=$HOME/.vim/spell/en.utf-8.add

au FileType sh setl sw=4 ts=4 et
au FileType perl setl sw=4 sts=4 et
au FileType python setl sw=4 sts=4 et
au FileType c setl sw=4 sts=4 et
au FileType json setl sw=2 sts=2 et
au FileType yaml setl sw=4 sts=4 et
au FileType robot setl sw=4 sts=4 et
au FileType html setl sw=2 sts=2 et
au FileType rst setl sw=2 sts=2 et
au FileType cucumber setl tw=79 sw=2 sts=2 et
au FileType kivy setl sw=4 sts=4 et

au BufReadPost *.http set syntax=html

set autoindent
set smartindent
set hlsearch

set encoding=utf-8

" better colors for vimdiff
if &diff
        colorscheme zellner
endif

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:·

" file browser pimping
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" -------------- Plugins ----------------
"  " https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'vim-python/python-syntax'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

" enable extra string formatting syntax highlighting from above plugin
let g:python_highlight_all = 1

