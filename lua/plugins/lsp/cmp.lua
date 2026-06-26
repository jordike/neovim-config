return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "ray-x/cmp-treesitter"
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup(
            {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
                    },
                    documentation = {
                        winhighlight = "Normal:NormalFloat,FloatBorder:NormalFloat"
                    }
                },
                formatting = {
                    fields = {"kind", "abbr", "menu"},
                    format = function(entry, vim_item)
                        local icons = {
                            Text = "󰉿",
                            Method = "󰆧",
                            Function = "󰊕",
                            Constructor = "",
                            Field = "󰜢",
                            Variable = "󰀫",
                            Class = "󰠱",
                            Interface = "",
                            Module = "",
                            Property = "󰜢",
                            Unit = "󰑭",
                            Value = "󰎠",
                            Enum = "",
                            Keyword = "󰌋",
                            Snippet = "",
                            Color = "󰏘",
                            File = "󰈙",
                            Reference = "󰈇",
                            Folder = "󰉋",
                            EnumMember = "",
                            Constant = "󰏿",
                            Struct = "󰙅",
                            Event = "",
                            Operator = "󰆕",
                            TypeParameter = "󰅲"
                        }

                        vim_item.kind = (icons[vim_item.kind] or "") .. " " .. vim_item.kind

                        vim_item.menu =
                            ({
                            nvim_lsp = "[LSP]",
                            buffer = "[BUF]",
                            path = "[PATH]",
                            treesitter = "[TS]",
                            luasnip = "[SNIP]"
                        })[entry.source.name]

                        return vim_item
                    end
                },
                sources = cmp.config.sources(
                    {
                        {name = "nvim_lsp"},
                        {name = "luasnip"},
                        {name = "path"},
                        {name = "buffer"},
                        {name = "treesitter"}
                    }
                ),
                mapping = cmp.mapping.preset.insert(
                    {
                        ["<CR>"] = cmp.mapping.confirm({select = false}),
                        ["<C-c>"] = cmp.mapping.complete(),
                        ["<C-k>"] = cmp.mapping.select_prev_item(),
                        ["<C-j>"] = cmp.mapping.select_next_item()
                    }
                )
            }
        )
    end
}
