" Share nvim config with vim (from https://www.baeldung.com/linux/vim-neovim-configs)
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
