syntax on
set ruler

au FileType perl setl sw=4 ts=4
au FileType python setl sw=4 sts=4 et
au FileType robot setl sw=4 sts=4 et
au FileType html setl sw=2 sts=2 et
au FileType rst setl sw=2 sts=2 et
au FileType cucumber setl tw=79 sw=2 sts=2 et

au BufReadPost *.http set syntax=html

set autoindent
set smartindent
set hlsearch


" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:·
