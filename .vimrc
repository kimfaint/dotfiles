syntax on
set ruler

au FileType perl setl ts=4 sw=4
au FileType python setl sw=4 sts=4 et
au FileType robot setl sw=4 sts=4 et
au FileType html setl sw=2 sts=2 et
au FileType cucumber setl tw=79 sw=2 sts=2 et
au FileType kivy setl sw=4 sts=4 et

au BufReadPost *.http set syntax=html

set autoindent
set smartindent
set hlsearch

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:·

" -------------- Plugins ----------------
"  " https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'atkenny15/vim-ghosttext'
Plug 'vim-python/python-syntax'
call plug#end()

" enable extra string formatting syntax highlighting from above plugin
let g:python_highlight_all = 1

" powerline statusline (pip3 install --user powerline-status)
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " allways display powerline ruler (:h 'laststatus' for options)
