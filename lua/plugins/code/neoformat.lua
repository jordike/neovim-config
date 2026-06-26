return {
    "sbdchd/neoformat",
    config = function()
        vim.g.neoformat_only_msg_on_error = 1
        vim.g.neoformat_basic_format_align = 1
        vim.g.neoformat_basic_format_retab = 1
        vim.g.neoformat_basic_format_trim = 1
        vim.g.neoformat_try_node_exe = 1
    end,
    keys = {
        {
            "<leader>f",
            function()
                vim.cmd("Neoformat")
            end,
            desc = "Formats the currently open buffer",
            silent = true
        }
    }
}
