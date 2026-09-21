return {
    'tiagovla/tokyodark.nvim',
    cmd = 'Colorscheme',
    config = function()
        require('tokyodark').setup({
            styles = {
                comments = {
                    italic = false,
                },
                keywords = {
                    italic = false,
                },
                identifiers = {
                    italic = false,
                },
                functions = {},
                variables = {},
            },
        })
    end,
}
