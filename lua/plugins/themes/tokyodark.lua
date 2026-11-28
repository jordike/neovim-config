return {
    'tiagovla/tokyodark.nvim',
    lazy = false,
    priority = 1000,
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
