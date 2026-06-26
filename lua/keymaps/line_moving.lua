-- move line up (normal mode)
vim.keymap.set(
    "n",
    "<A-j>",
    ":m .+1<CR>==",
    {
        silent = true
    }
)

 -- move line down (normal mode)
vim.keymap.set(
    "n",
    "<A-k>",
    ":m .-2<CR>==",
    {
        silent = true
    }
)

 -- move line up (visual mode)
vim.keymap.set(
    "v",
    "<A-j>",
    ":m '>+1<CR>gv=gv",
    {
        silent = true
    }
)

 -- move line down (visual mode)
vim.keymap.set(
    "v",
    "<A-k>",
    ":m '<-2<CR>gv=gv",
    {
        silent = true
    }
)
