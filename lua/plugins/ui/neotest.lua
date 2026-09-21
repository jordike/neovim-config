return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',

        -- Test adapters
        'nvim-neotest/neotest-python',
        'haydenmeade/neotest-jest',
        'marilari88/neotest-vitest',
        'sidlatau/neotest-dart',
        'V13Axel/neotest-pest',
        'Issafalcon/neotest-dotnet',
        'rcasia/neotest-java',
        'codymikol/neotest-kotlin',
        'alfaix/neotest-gtest',
        'orjangj/neotest-ctest',
    },
    cmd = {
        'Neotest',
    },
    config = function()
        require('neotest').setup({
            adapters = {
                -- require('neotest-python'),
                -- require('neotest-jest'),
                -- require('neotest-vitest'),
                -- require('neotest-dart'),
                -- require('neotest-pest'),
                require('neotest-dotnet'),
                -- require('neotest-java'),
                -- require('neotest-kotlin'),
                -- require('neotest-gtest'),
                -- require('neotest-ctest'),
            },
            config = {
                output_panel = { open_on_run = true },
                diagnostic = true,
            },
        })
    end,
    keys = {
        {
            '<leader>nts',
            function()
                require('neotest').summary.toggle()
            end,
            desc = 'Toggle Neotest summary',
            silent = true,
        },
        {
            '<leader>ntr',
            function()
                require('neotest').run.run()
            end,
            desc = 'Run Neotest tests',
            silent = true,
        },
        {
            '<leader>nta',
            function()
                require('neotest').run.run(vim.fn.getcwd())
            end,
            desc = 'Run all Neotest tests',
            silent = true,
        },
    },
}
