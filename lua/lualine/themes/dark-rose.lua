local c = {
    bg = '#202020',
    bg_alt = '#2b2b2b',
    fg = '#d3d3d3',
    fg_dim = '#a3a3a3',
    red = '#c2436d',
    green = '#82be8b',
    orange = '#ee9c76',
    blue = '#7d91af',
    visual = '#5b3642',
}

return {
    normal = {
        a = { bg = c.red, fg = c.bg, gui = 'bold' },
        b = { bg = c.bg_alt, fg = c.fg },
        c = { bg = c.bg, fg = c.fg },
    },
    insert = {
        a = { bg = c.green, fg = c.bg, gui = 'bold' },
        b = { bg = c.bg_alt, fg = c.fg },
    },
    visual = {
        a = { bg = c.visual, fg = c.fg, gui = 'bold' },
        b = { bg = c.bg_alt, fg = c.fg },
    },
    replace = {
        a = { bg = c.orange, fg = c.bg, gui = 'bold' },
        b = { bg = c.bg_alt, fg = c.fg },
    },
    command = {
        a = { bg = c.blue, fg = c.bg, gui = 'bold' },
        b = { bg = c.bg_alt, fg = c.fg },
    },
    inactive = {
        a = { bg = c.bg, fg = c.fg_dim },
        b = { bg = c.bg, fg = c.fg_dim },
        c = { bg = c.bg, fg = c.fg_dim },
    },
}
