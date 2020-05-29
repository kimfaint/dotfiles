syntax on
set ruler

set spelllang=en_au
set spellfile=$HOME/.vim/spell/en.utf-8.add

au FileType perl setl sw=4 ts=4
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
        colorscheme desert
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
"Plug 'atkenny15/vim-ghosttext'
"" Only enabled for Vim 8 (not for Neovim).
Plug 'roxma/nvim-yarp', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
Plug 'roxma/vim-hug-neovim-rpc', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'vim-python/python-syntax'
Plug 'scrooloose/nerdtree'
call plug#end()

" enable extra string formatting syntax highlighting from above plugin
let g:python_highlight_all = 1

" powerline statusline (pip3 install --user powerline-status)
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " allways display powerline ruler (:h 'laststatus' for options)
