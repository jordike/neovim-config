return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require('nvim-treesitter.configs').setup({
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "angular",
                "bash",
                "c_sharp",
                "cmake",
                "cpp",
                "css",
                "csv",
                "dart",
                "dockerfile",
                "diff",
                "doxygen",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "html",
                "html",
                "java",
                "javadoc",
                "javascript",
                "jsdoc",
                "jsonc",
                -- "latex",
                "lua",
                "luadoc",
                "luap",
                "luau",
                "make",
                "markdown",
                "markdown_inline",
                "php",
                "phpdoc",
                "powershell",
                "printf",
                "properties",
                "pug",
                "python",
                "razor",
                "regex",
                "requirements",
                "rust",
                "scala",
                "sql",
                "tmux",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "xml",
                "yaml"
            },

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
    end,
    build = ":TSUpdate",
    branch = "master",
    lazy = false
}
