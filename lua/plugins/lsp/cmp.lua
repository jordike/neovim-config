return {
    'ray-x/cmp-treesitter',
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            "onsails/lspkind.nvim"
        }
    },
    'hrsh7th/cmp-nvim-lsp',
    config = function()
        local cmp = require('cmp')
        local lspkind = require("lspkind")
        local luasnip = require('luasnip')

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'treesitter' },
                { name = 'path' },
            }),
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({
                    select = false
                }),
                ['<C-c>'] = cmp.mapping.complete(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
            }),
            -- window = {
            --     completion = {
            --         winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            --         side_padding = 0,
            --     },
            -- },
            formatting = {
                fields = { "kind", "abbr" },
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = {
                        menu = 50,
                        abbr = 50
                    },
                    ellipsis_char = '...',
                    show_labelDetails = true,
                    menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]",
                    })
                })
            }
        })

        vim.lsp.config('ts_ls', {
            filetypes = {
                'vue',
                'typescript',
                'javascript',
            },
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vim.fn.expand(vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"), languages = { "vue" },
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
    end
}
