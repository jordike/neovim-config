return {
    'mason-org/mason.nvim',
    dependencies = {
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    cmd = {
        'Mason',
        'MasonInstall',
        'MasonUpdate',
    },
    event = 'BufReadPre',
    config = function()
        require('mason').setup()

        require('mason-lspconfig').setup({
            automatic_enable = {
                exclude = {
                    'omnisharp_mono',
                    'vtsls',
                    'dockerls',
                    'css_variables',
                },
            },
            ensure_installed = {
                'ts_ls',
                'pest_ls',
                'kotlin_lsp',
                'laravel_ls',
                'asm_lsp',
                'docker_language_server',
                'html',
                'cssmodules_ls',
                'jsonls',
                'yamlls',
                'clangd',
                'arduino_language_server',
                'ltex',
                'dockerls',
                'omnisharp',
                'luau_lsp',
                'bashls',
                'tailwindcss',
                'cssls',
                'lua_ls',
                'vue_ls',
                'intelephense',
                'gh_actions_ls',
                'rust_analyzer',
                'emmet_ls',
                'eslint',
                'vimls',
            },
        })

        require('mason-tool-installer').setup({
            ensure_installed = {
                -- Linters
                'pylint',
                'eslint_d',
                'jsonlint',
                'cpplint',
                'cmakelang',
                'cmakelint',

                -- DAP
                'netcoredbg',
                'js-debug-adapter',
                'codelldb',
                'dart-debug-adapter',
                'php-debug-adapter',

                -- Formatters
                'pint',
                'xmlformatter',
                'yamlfmt',
                'prettier',
                'clang-format',
                'blade-formatter',
                'luafmt',
                'csharpier',
            },
        })
    end,
}
