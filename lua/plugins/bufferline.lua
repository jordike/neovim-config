return {
    "akinsho/bufferline.nvim",
    config = function()
        local bufferline = require("bufferline")

        bufferline.setup({
            options = {
                style_preset = bufferline.style_preset.default,
                themable = true,
                offsets = {
                    {
                        filetype = "neo-tree",
                        seperator = false
                    }
                },
                separator_style = "slant",
                diagnostics = "nvim_lsp",
                numbers = "buffer_id",
                color_icons = true,
                hover = {
                    enabled = true,
                    reveal = {
                        "close"
                    }
                },
                indicator = {
                    style = "none"
                },
                show_tab_indicators = true,
                show_duplicate_prefix = true
            },
            highlights = {
                buffer_selected = {
                   italic = false
                },
                numbers_selected = {
                    italic = false
                }
            }
        })
    end
}
