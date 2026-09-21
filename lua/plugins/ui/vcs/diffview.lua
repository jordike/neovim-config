return {
    'sindrets/diffview.nvim',
    cmd = {
        'DiffviewOpen',
        'DiffviewClose',
        'DiffviewFileHistory',
    },
    keys = {
        {
            '<leader>do',
            function()
                vim.cmd('DiffviewOpen')
            end,
            desc = 'Open diffview',
            silent = true,
        },
        {
            '<leader>dc',
            function()
                vim.cmd('DiffviewClose')
            end,
            desc = 'Close diffview',
            silent = true,
        },
        {
            '<leader>dh',
            function()
                vim.cmd('DiffviewFIleHistory')
            end,
            desc = 'Open file history',
            silent = true,
        },
    },
}
