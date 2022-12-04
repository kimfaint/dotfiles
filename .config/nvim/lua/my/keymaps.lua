-- map leader key to spacebar
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- automatically :w write file before running certain commands such as :! and :make
vim.opt.autowrite = true

-- automatically re-read file if modified by something else
vim.opt.autoread = true

-- undeline the current line
vim.opt.cursorline = true

-- tabs v spaces
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftround = true

-- key mapping to clear search
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
