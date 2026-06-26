return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    keys = {
        {
            "<leader>tf",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Telescope find files"
        },
        {
            "<leader>tb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Telescope buffers"
        },
        {
            "<leader>tg",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Telescope live grep"
        },
        {
            "<leader>td",
            function()
                require("telescope.builtin").lsp_definitions()
            end,
            desc = "Telescope LSP definitions"
        },
        {
            "<leader>tr",
            function()
                require("telescope.builtin").lsp_references()
            end,
            desc = "Telescope LSP references"
        },
        {
            "<leader>ts",
            function()
                require("telescope.builtin").lsp_document_symbols()
            end,
            desc = "Telescope LSP symbols"
        },
        {
            "<leader>tm",
            function()
                require("telescope.builtin").marks()
            end,
            desc = "Telescope marks"
        },
        {
            "<leader>th",
            function()
                require("telescope.utils").notify()
            end,
            desc = "Telescope notify history"
        }
    }
}
