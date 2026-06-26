return {
    "sindrets/diffview.nvim",
    keys = {
        {
            "<leader>do",
            function()
                vim.cmd("DiffviewOpen")
            end,
            desc = "Open diffview"
        },
        {
            "<leader>dc",
            function()
                vim.cmd("DiffviewClose")
            end,
            desc = "Close diffview"
        }
    },
    lazy = false
}
