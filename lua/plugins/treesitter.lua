return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require('nvim-treesitter.configs').setup({
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = "all",

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                enable = true,
            },

            use_treesitter = true,

            indent = {
                enable = true
            }
        })

        require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter.install").compilers = {
            "clang"
        }
    end
}
