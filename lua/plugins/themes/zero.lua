return {
    'czrd/zero.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('zero').setup({
            style = 'dark',
        })
    end,
}
