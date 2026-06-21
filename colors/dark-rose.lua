vim.g.colors_name = "dark-rose"

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true

local c = {
    bg = "#202020",
    bg_alt = "#252525",
    bg_panel = "#242424",
    status_bg = "#1e1e1e",
    fg = "#d3d3d3",
    fg_dim = "#5f5f5f",
    comment = "#7e7e7e",
    red = "#c2436d",
    purple = "#b0a2e0",
    blue = "#4788bd",
    blue_dark = "#7d91af",
    orange = "#ee9c76",
    green = "#82be8b",
    border = "#454545",
    visual = "#5b3642",
    search = "#3f5a44",
    incsearch = "#4c5b4e"
}

local hl = vim.api.nvim_set_hl

-- =========================================================
-- UI
-- =========================================================

hl(0, "Normal", {fg = c.fg, bg = c.bg})
hl(0, "NormalFloat", {fg = c.fg, bg = c.bg_panel})
hl(0, "FloatBorder", {fg = c.border, bg = c.bg_panel})

hl(0, "CursorLine", {bg = c.bg_alt})
hl(0, "Visual", {bg = c.visual})

hl(0, "LineNr", {fg = c.fg_dim})
hl(0, "CursorLineNr", {fg = c.red})

hl(0, "Search", {bg = c.search})
hl(0, "IncSearch", {bg = c.incsearch})

hl(0, "StatusLine", {fg = c.fg, bg = c.status_bg})
hl(0, "StatusLineNC", {fg = c.fg_dim, bg = c.status_bg})

hl(0, "VertSplit", {fg = c.border})
hl(0, "WinSeparator", {fg = c.border})

hl(0, "MatchParen", {fg = c.red, bold = true})

-- =========================================================
-- BASE SYNTAX
-- =========================================================

hl(0, "Comment", {fg = c.comment, italic = true})
hl(0, "Keyword", {fg = c.red})
hl(0, "Operator", {fg = "#9a9a9a"})

hl(0, "String", {fg = c.green})
hl(0, "Number", {fg = c.orange})
hl(0, "Boolean", {fg = c.orange})
hl(0, "Constant", {fg = c.orange})

hl(0, "Function", {fg = c.blue_dark})
hl(0, "Identifier", {fg = c.fg})

hl(0, "Type", {fg = c.orange})

-- =========================================================
-- TREE-SITTER CORE
-- =========================================================

hl(0, "@keyword", {fg = c.red})

hl(0, "@function", {fg = c.blue_dark})
hl(0, "@method", {fg = c.blue_dark})

hl(0, "@variable", {fg = c.fg})
hl(0, "@property", {fg = c.fg})

hl(0, "@string", {fg = c.green})
hl(0, "@number", {fg = c.orange})

-- =========================================================
-- PUNCTUATION / OPERATORS
-- =========================================================

local punctuation = "#a3a3a3"

hl(0, "@punctuation", {fg = punctuation})
hl(0, "@punctuation.bracket", {fg = punctuation})
hl(0, "@punctuation.delimiter", {fg = punctuation})
hl(0, "@punctuation.special", {fg = punctuation})

hl(0, "@operator", {fg = "#9a9a9a"})
hl(0, "@operator.import", {fg = c.orange})

-- =========================================================
-- TYPESCRIPT FIX (ONLY REAL TYPE NODES)
-- =========================================================

hl(0, "@variable.parameter.type", {fg = c.orange})
hl(0, "@variable.parameter", {fg = c.fg})

hl(0, "@type", {fg = c.orange})
hl(0, "@type.builtin", {fg = c.orange})

-- =========================================================
-- LSP TYPES (SAFE LAYER)
-- =========================================================

hl(0, "@lsp.type.type", {fg = c.orange})
hl(0, "@lsp.type.class", {fg = c.orange})
hl(0, "@lsp.type.interface", {fg = c.orange})
hl(0, "@lsp.type.enum", {fg = c.orange})
hl(0, "@lsp.type.typeParameter", {fg = c.orange})

hl(0, "@lsp.type.function", {fg = c.blue_dark})
hl(0, "@lsp.type.method", {fg = c.blue_dark})

hl(0, "@lsp.type.variable", {fg = c.fg})
hl(0, "@lsp.type.parameter", {fg = c.fg})
hl(0, "@lsp.type.property", {fg = c.fg})

hl(0, "@lsp.type.string", {fg = c.green})
hl(0, "@lsp.type.number", {fg = c.orange})
hl(0, "@lsp.type.boolean", {fg = c.orange})

-- =========================================================
-- 🔥 FINAL CYAN FIX (null / undefined / * / builtin values)
-- =========================================================

hl(0, "@lsp.type.keyword", {fg = c.orange})
hl(0, "@lsp.type.builtin", {fg = c.orange})
hl(0, "@lsp.type.operator", {fg = c.orange})

hl(0, "@lsp.mod.defaultLibrary", {fg = c.orange})

-- =========================================================
-- HTML / TSX
-- =========================================================

hl(0, "@tag", {fg = c.orange})
hl(0, "@tag.builtin", {fg = c.orange})
hl(0, "@tag.delimiter", {fg = punctuation})
hl(0, "@tag.attribute", {fg = c.blue_dark})

-- =========================================================
-- DIAGNOSTICS
-- =========================================================

hl(0, "DiagnosticError", {fg = c.red})
hl(0, "DiagnosticWarn", {fg = c.orange})
hl(0, "DiagnosticInfo", {fg = c.blue})
hl(0, "DiagnosticHint", {fg = c.fg_dim})

hl(0, "DiagnosticUnderlineError", {undercurl = true, sp = c.red})
hl(0, "DiagnosticUnderlineWarn", {undercurl = true, sp = c.orange})

-- =========================================================
-- NEOTREE
-- =========================================================

hl(0, "NeoTreeNormal", {fg = c.fg, bg = c.bg_panel})
hl(0, "NeoTreeNormalNC", {fg = c.fg, bg = c.bg_panel})

hl(0, "NeoTreeDirectoryName", {fg = c.blue_dark})
hl(0, "NeoTreeFileName", {fg = c.fg})
hl(0, "NeoTreeRootName", {fg = c.red, bold = true})

hl(0, "NeoTreeIndentMarker", {fg = "#3a3a3a"})

hl(0, "NeoTreeGitAdded", {fg = c.green})
hl(0, "NeoTreeGitModified", {fg = c.orange})
hl(0, "NeoTreeGitDeleted", {fg = c.red})
