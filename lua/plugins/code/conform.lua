return {
    'stevearc/conform.nvim',
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    opts = {
        formatters_by_ft = {
            asm = { 'asmfmt' },
            blade = { 'blade-formatter' },
            c = { 'clang_format' },
            cpp = { 'clang_format' },
            cs = { 'csharpier' },
            css = { 'prettier' },
            dart = { 'dart_format' },
            go = { 'gofmt' },
            html = { 'prettier' },
            javascript = { 'prettier' },
            javascriptreact = { 'prettier' },
            json = { 'prettier' },
            kotlin = { 'ktlint' },
            lua = { 'stylua' },
            markdown = { 'prettier' },
            php = { 'pint' },
            python = { 'ruff_format' },
            rust = { 'rustfmt' },
            scss = { 'prettier' },
            sh = { 'shfmt' },
            swift = { 'swift' },
            typescript = { 'prettier' },
            typescriptreact = { 'prettier' },
            vue = { 'prettier' },
            xml = { 'xmlformatter' },
            yaml = { 'prettier' },
        },
        formatters = {
            clang_format = {
                prepend_args = { '--style=file' },
            },
        },
    },
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format()
            end,
            desc = 'Runs code formatters',
            silent = true,
        },
    },
}
