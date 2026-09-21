return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
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
            automatic_installation = true,
            ensure_installed = {
                'ts_ls',
                'pest_ls',
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
    end,
}
