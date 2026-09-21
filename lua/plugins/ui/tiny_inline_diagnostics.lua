return {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'BufReadPost',
    config = function()
        require('tiny-inline-diagnostic').setup({
            preset = 'classic',
        })

        -- Disable Neovim's default virtual text diagnostics
        vim.diagnostic.config({
            virtual_text = false,
        })
    end,
}
