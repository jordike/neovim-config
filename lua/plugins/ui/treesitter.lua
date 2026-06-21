return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'master',
    lazy = false,
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'c',
                'lua',
                'vim',
                'vimdoc',
                'query',
                'markdown',
                'markdown_inline',
                'angular',
                'bash',
                'c_sharp',
                'cmake',
                'cpp',
                'css',
                'csv',
                'dart',
                'dockerfile',
                'diff',
                'doxygen',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'go',
                'gomod',
                'gosum',
                'gotmpl',
                'html',
                'html',
                'java',
                'javadoc',
                'javascript',
                'jsdoc',
                'jsonc',
                -- 'latex',
                'lua',
                'luadoc',
                'luap',
                'luau',
                'make',
                'markdown',
                'markdown_inline',
                'php',
                'phpdoc',
                'powershell',
                'printf',
                'properties',
                'pug',
                'python',
                'razor',
                'regex',
                'requirements',
                'rust',
                'scala',
                'sql',
                'tmux',
                'typescript',
                'vim',
                'vimdoc',
                'vue',
                'xml',
                'yaml'
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
            },
            use_treesitter = true,
            indent = {
                enable = true
            }
        })

        require('nvim-treesitter.install').prefer_git = true
        require('nvim-treesitter.install').compilers = {
            'clang'
        }
    end
}
