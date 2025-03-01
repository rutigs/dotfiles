vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set foldmethod=indent")
vim.cmd("set nofoldenable")
vim.cmd("set clipboard=unnamedplus") --- unnamed on mac os
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    command = "setlocal shiftwidth=2 tabstop=2"
})

vim.cmd("au TermOpen * setlocal nonumber")

vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set('n', 'ge', ':lua vim.diagnostic.open_float() <CR>')
