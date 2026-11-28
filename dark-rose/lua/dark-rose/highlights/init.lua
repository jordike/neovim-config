local palette = require('dark-rose.palette')

local M = {}

local function hl(group, spec)
    vim.api.nvim_set_hl(0, group, spec)
end

local function link(group, target)
    vim.api.nvim_set_hl(0, group, { link = target })
end

function M.apply()
    require('dark-rose.highlights.editor')(palette, hl, link)
    require('dark-rose.highlights.syntax')(palette, hl, link)
    require('dark-rose.highlights.integrations')(palette, hl, link)
end

return M
