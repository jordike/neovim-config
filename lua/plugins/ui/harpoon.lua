return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            {
                '<leader>ha',
                function()
                    require('harpoon'):list():add()
                end,
                desc = 'Harpoon: Add file',
            },
            {
                '<leader>he',
                function()
                    local harpoon = require('harpoon')
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = 'Harpoon: Toggle menu',
            },
            {
                '<leader>hp',
                function()
                    require('harpoon'):list():prev()
                end,
                desc = 'Harpoon: Previous file',
            },
            {
                '<leader>hn',
                function()
                    require('harpoon'):list():next()
                end,
                desc = 'Harpoon: Next file',
            },
            {
                '<leader>h1',
                function()
                    require('harpoon'):list():select(1)
                end,
                desc = 'Harpoon: Select file 1',
            },
            {
                '<leader>h2',
                function()
                    require('harpoon'):list():select(2)
                end,
                desc = 'Harpoon: Select file 2',
            },
            {
                '<leader>h3',
                function()
                    require('harpoon'):list():select(3)
                end,
                desc = 'Harpoon: Select file 3',
            },
            {
                '<leader>h4',
                function()
                    require('harpoon'):list():select(4)
                end,
                desc = 'Harpoon: Select file 4',
            },
        },
        config = function()
            require('harpoon'):setup()
        end,
    },
}
