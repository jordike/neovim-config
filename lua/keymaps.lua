vim.g.mapleader = '\\'

-- Telescope
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', {
    silent = true
})
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', {
    silent = true
})
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>', {
    silent = true
})
vim.keymap.set('n', '<leader>d', ':Telescope lsp_definitions<CR>', {
    silent = true
})
vim.keymap.set('n', '<leader>r', ':Telescope lsp_references<CR>', {
    silent = true
})
vim.keymap.set('n', '<leader>s', ':Telescope symbols<CR>', {
    silent = true
})
vim.keymap.set('n', '<leader>m', ':Telescope marks<CR>', {
    silent = true
})

vim.keymap.set('n', '<Tab>', ':Neotree toggle<CR>', {
    silent = true
})

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {
    silent = true
}) -- move line up(n)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {
    silent = true
}) -- move line down(n)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", {
    silent = true
}) -- move line up(v)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", {
    silent = true
}) -- move line down(v)
