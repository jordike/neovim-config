return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        {
            "folke/neoconf.nvim",
            cmd = "Neoconf",
            config = true
        },
        {
            "folke/neodev.nvim",
            config = true
        },
        "williamboman/mason.nvim",
        {
            "williamboman/mason-lspconfig.nvim",
            config = {
                automatic_installation = true
            }
        },
        "ray-x/cmp-treesitter",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip"
    },
    config = function()
        require("mason").setup()

        local masonConfig = require("mason-lspconfig")
        local lspConfig = require("lspconfig")
        local cmpNvimLsp = require("cmp_nvim_lsp")
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        masonConfig.setup({
            automatic_installation = true,
            ensure_installed = {
                "clangd",    -- C and C++
                "csharp_ls",
                "cmake",
                "cssls",
                "dockerls",
                "eslint",
                "emmet_ls",
                "html",
                "jsonls",
                "jdtls",     -- Java
                "tsserver", -- Typescript and Javascript
                "lua_ls",
                "marksman", -- Markdown
                "intelephense", -- PHP
                "pyright",  -- Python
                "rust_analyzer",
                "sqlls",
                "tailwindcss",
                "taplo",     -- Toml,
                "volar"     -- Vue
            }
        })
        local capabilities = cmpNvimLsp.default_capabilities()

        masonConfig.setup_handlers({
            function(serverName)
                lspConfig[serverName].setup({
                    capabilities = capabilities
                })
            end,
        })


        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "treesitter" },
                { name = "path" }
            }),
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({
                    select = false 
                }),
                ["<C-c>"] = cmp.mapping.complete(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item()
            }),
            -- window = {
            --     completion = cmp.config.window.bordered()
            -- }
        })
    end
}
