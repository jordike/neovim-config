return {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    config = function()
        require('ibl').setup({
            scope = {
                enabled = false,
            },
        })
    end,
}
