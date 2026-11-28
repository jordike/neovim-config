local c = require('dark-rose.palette')

return {
    normal = {
        a = { bg = c.red, fg = c.bg, gui = 'bold' },
        b = { bg = c.status, fg = c.fg },
        c = { bg = c.status, fg = c.fg },
    },
    insert = {
        a = { bg = c.green, fg = c.bg, gui = 'bold' },
        b = { bg = c.status, fg = c.fg },
    },
    visual = {
        a = { bg = c.selection, fg = c.fg, gui = 'bold' },
        b = { bg = c.status, fg = c.fg },
    },
    replace = {
        a = { bg = c.orange, fg = c.bg, gui = 'bold' },
        b = { bg = c.status, fg = c.fg },
    },
    command = {
        a = { bg = c.blue_dark, fg = c.bg, gui = 'bold' },
        b = { bg = c.status, fg = c.fg },
    },
    inactive = {
        a = { bg = c.status, fg = c.punctuation },
        b = { bg = c.status, fg = c.punctuation },
        c = { bg = c.status, fg = c.punctuation },
    },
}
