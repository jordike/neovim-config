vim.g.mapleader = "\\"

-- Telescope
vim.keymap.set(
    "n",
    "<leader>tf",
    ":Telescope find_files<CR>",
    {
        silent = true
    }
)
vim.keymap.set(
    "n",
    "<leader>tb",
    ":Telescope buffers<CR>",
    {
        silent = true
    }
)
vim.keymap.set(
    "n",
    "<leader>tg",
    ":Telescope live_grep<CR>",
    {
        silent = true
    }
)
vim.keymap.set(
    "n",
    "<leader>td",
    ":Telescope lsp_definitions<CR>",
    {
        silent = true
    }
)
vim.keymap.set(
    "n",
    "<leader>tr",
    ":Telescope lsp_references<CR>",
    {
        silent = true
    }
)
vim.keymap.set(
    "n",
    "<leader>ts",
    ":Telescope lsp_document_symbols<CR>",
    {
        silent = true
    }
)
vim.keymap.set(
    "n",
    "<leader>tm",
    ":Telescope marks<CR>",
    {
        silent = true
    }
)

-- Diffview
vim.keymap.set(
    "n",
    "<leader>do",
    ":DiffviewOpen<CR>",
    {
        silent = true
    }
)
vim.keymap.set(
    "n",
    "<leader>dc",
    ":DiffviewClose<CR>",
    {
        silent = true
    }
)

-- Gitsign
vim.keymap.set(
    "n",
    "<leader>gb",
    ":Gitsign blame_line<CR>",
    {
        silent = true
    }
)

-- Neotree
vim.keymap.set(
    "n",
    "<Tab>",
    ":Neotree toggle<CR>",
    {
        silent = true
    }
)

-- Move lines
vim.keymap.set(
    "n",
    "<A-j>",
    ":m .+1<CR>==",
    {
        silent = true
    }
) -- move line up(n)
vim.keymap.set(
    "n",
    "<A-k>",
    ":m .-2<CR>==",
    {
        silent = true
    }
) -- move line down(n)
vim.keymap.set(
    "v",
    "<A-j>",
    ":m '>+1<CR>gv=gv",
    {
        silent = true
    }
) -- move line up(v)
vim.keymap.set(
    "v",
    "<A-k>",
    ":m '<-2<CR>gv=gv",
    {
        silent = true
    }
) -- move line down(v)
