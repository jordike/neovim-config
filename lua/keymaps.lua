vim.g.mapleader = " "

vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<CR>", {
    silent = true
})

vim.keymap.set("n", "<Tab>", ":Neotree toggle<CR>", {
    silent = true
})

vim.keymap.set("n", "<leader>n", ":BufferLineCyclePrev<CR>", {
    silent = true
})
vim.keymap.set("n", "<leader>m", ":BufferLineCycleNext<CR>", {
    silent = true
})

vim.keymap.set("n", "<leader>p", ":BufferLineTogglePin<CR>", {
    silent = true
})

vim.keymap.set("n", "<leader>d", ":CocDiagnostics<CR>", {
    silent = true
})

vim.keymap.set("n", "gd", ":CocAction('jumpDefinition')<CR>", {
    silent = true
})
vim.keymap.set("n", "gi", ":CocAction('jumpImplementation')<CR>", {
    silent = true
})

vim.keymap.set("n", "td", ":Telescope lsp_definitions<CR>", {
    silent = true
})
vim.keymap.set("n", "tr", ":Telescope lsp_references<CR>", {
    silent = true
})

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", {
    silent = true
}) -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", {
    silent = true
}) -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", {
    silent = true
}) -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", {
    silent = true
}) -- move line down(v)
