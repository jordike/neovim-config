return {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    config = function()
        local masonLspConfig = require('mason-lspconfig')

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
    end
}
