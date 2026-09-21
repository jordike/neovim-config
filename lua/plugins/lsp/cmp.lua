return {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
        'folke/lazydev.nvim',
        'L3MON4D3/LuaSnip',
        'brenoprata10/nvim-highlight-colors',
    },
    event = 'InsertEnter',
    opts = {
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            documentation = {
                auto_show = true,
            },
        },
        snippets = {
            preset = 'luasnip',
        },
        sources = {
            default = {
                'lsp',
                'path',
                'snippets',
                'buffer',
                'lazydev',
            },
            providers = {
                lazydev = {
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
            },
        },
        keymap = {
            preset = 'default',
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C-c>'] = { 'show', 'fallback' },
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
        },
    },
}
