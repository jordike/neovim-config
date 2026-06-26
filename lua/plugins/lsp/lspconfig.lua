return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.lsp.config(
            "ts_ls",
            {
                filetypes = {
                    "vue",
                    "typescript",
                    "javascript"
                },
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.expand(
                                vim.fn.stdpath "data" ..
                                    "/mason/packages/vue-language-server/node_modules/@vue/language-server"
                            ),
                            languages = {"vue"}
                        }
                    }
                }
            }
        )

        vim.lsp.config(
            "vue_ls",
            {
                filetypes = {
                    "vue",
                    "typescript",
                    "javascript"
                }
            }
        )

        vim.lsp.config(
            "lua_ls",
            {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"}
                        }
                    }
                }
            }
        )
    end,
    lazy = false
}
