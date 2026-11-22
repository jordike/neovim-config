return {
    'sindrets/diffview.nvim',
    cmd = {
        'DiffviewOpen',
        'DiffviewClose',
        'DiffviewFileHistory',
    },
    keys = {
        {
            '<leader>dvo',
            function()
                vim.cmd('DiffviewOpen')
            end,
            desc = 'Open diffview',
            silent = true,
        },
        {
            '<leader>dvc',
            function()
                vim.cmd('DiffviewClose')
            end,
            desc = 'Close diffview',
            silent = true,
        },
        {
            '<leader>dvh',
            function()
                vim.cmd('DiffviewFIleHistory')
            end,
            desc = 'Open diffview file history',
            silent = true,
        },
    },
}
