return {
    'neovim/nvim-lspconfig',
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    config = function()
        vim.lsp.config('ts_ls', {
            filetypes = {
                'vue',
                'typescript',
                'javascript',
            },
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vim.fn.expand(
                            vim.fn.stdpath('data')
                                .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
                        ),
                        languages = { 'vue' },
                    },
                },
            },
        })

        vim.lsp.config('vue_ls', {
            filetypes = {
                'vue',
                'typescript',
                'javascript',
            },
        })

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })

        vim.lsp.config("clangd", {
            root_markers = {
                "compile_commands.json",
                "compile_flags.txt",
                ".clangd",
                ".git",
                ".hg",
                ".svn",
            },

            init_options = {
                fallbackFlags = {
                    "-std=c++20",
                },
            },

            before_init = function(params, config)
                local root = vim.uri_to_fname(params.rootUri)

                vim.list_extend(config.init_options.fallbackFlags, {
                    "-I" .. root,
                    "-I" .. vim.fs.joinpath(root, "include"),
                })
            end,
        })
    end,
}
