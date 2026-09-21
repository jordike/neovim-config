return {
    'czrd/zero.nvim',
    cmd = 'Colorscheme',
    config = function()
        require('zero').setup({
            style = 'dark',
        })
    end,
}
