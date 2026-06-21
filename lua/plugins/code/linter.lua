return {
    "mfussenegger/nvim-lint",
    config = function()
        require("lint").linters_by_ft = {
            javascript = { "eslint" },
            javascriptreact = { "eslint" },
            typescript = { "eslint" },
            typescriptreact = { "eslint" },
            vue = { "eslint" },
            svelte = { "eslint" },
            html = { "htmlhint" },
            css = { "stylelint" },
            json = { "jsonlint" },
            json5 = { "json5" },
            markdown = { "markdownlint" },
            yaml = { "yamllint" },
            toml = { "taplo" },
            python = { "ruff" },
            lua = { "selene" },
            sh = { "shellcheck" },
            bash = { "shellcheck" },
            zsh = { "zsh" },
            dockerfile = { "hadolint" },
            terraform = { "tflint" },
            hcl = { "tflint" },
            go = { "golangcilint" },
            rust = { "clippy" },
            c = { "clangtidy" },
            cpp = { "clangtidy" },
            php = { "phpstan" },
            text = { "vale" },
            sql = { "sqlfluff" },
            make = { "checkmake" },
            cmake = { "cmakelint" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
