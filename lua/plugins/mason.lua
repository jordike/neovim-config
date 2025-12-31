return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'ray-x/cmp-treesitter',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
    },
    config = function()
        require('mason').setup()

        local masonLspConfig = require('mason-lspconfig')
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        masonLspConfig.setup({
            automatic_installation = true,
            ensure_installed = {
                'ts_ls',
                'pest_ls',
                'nginx_language_server',
                'kotlin_lsp',
                'laravel_ls',
                'asm_lsp',
                'docker_language_server',
                'html',
                'css_variables',
                'cssmodules_ls',
                'jsonls',
                'vtsls',
                'yamlls',
                'clangd',
                'arduino_language_server',
                'ltex',
                'dockerls',
                'omnisharp_mono',
                'luau_lsp',
                'bashls',
                'tailwindcss',
                'cmake',
                'cssls',
                'lua_ls',
                'vue_ls',
                'intelephense',
                'gh_actions_ls',
                'rust_analyzer',
                'emmet_ls',
                'eslint',
                'vimls',
            }
        })

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
                        location = vim.fn.expand(vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"),
                        languages = { "vue" },
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
    end,
}
