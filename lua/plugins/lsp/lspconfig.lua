local function find_project_root(fname)
    if not fname or fname == '' then
        return vim.loop.cwd()
    end

    local markers = {
        'compile_commands.json',
        'compile_flags.txt',
        '.clangd',
        'CMakeLists.txt',
        'Makefile',
        'makefile',
        'meson.build',
        'BUILD',
        'BUILD.bazel',
        'configure.ac',
    }

    local root = vim.fs.root(fname, markers)
    if root then
        return root
    end

    -- Prefer the closest ancestor that actually looks like a
    -- source tree instead of jumping all the way to a parent .git directory.
    local dir = vim.fs.dirname(fname)
    while dir and dir ~= vim.fs.dirname(dir) do
        if
            vim.fn.isdirectory(vim.fs.joinpath(dir, 'src')) == 1
            or vim.fn.isdirectory(vim.fs.joinpath(dir, 'include')) == 1
        then
            return dir
        end
        dir = vim.fs.dirname(dir)
    end

    return vim.fs.root(fname, '.git') or vim.fs.dirname(fname)
end

local function include_dirs(root, fname)
    local dirs = {}
    local seen = {}

    local function add(path)
        if not path or path == '' then
            return
        end
        path = vim.fs.normalize(path)
        if vim.fn.isdirectory(path) == 1 and not seen[path] then
            seen[path] = true
            table.insert(dirs, path)
        end
    end

    add(root)
    add(vim.fs.joinpath(root, 'include'))
    add(vim.fs.joinpath(root, 'inc'))
    add(vim.fs.joinpath(root, 'src'))
    add(vim.fs.joinpath(root, 'src', 'include'))
    add(vim.fs.joinpath(root, 'src', 'inc'))

    for _, name in ipairs({ 'include', 'inc' }) do
        for _, path in ipairs(vim.fs.find(name, { path = root, type = 'directory', limit = 8 })) do
            add(path)
        end
    end

    if fname and fname ~= '' then
        local dir = vim.fs.dirname(vim.fs.normalize(fname))
        while dir and #dir >= #root do
            add(dir)
            if dir == root then
                break
            end
            local parent = vim.fs.dirname(dir)
            if parent == dir then
                break
            end
            dir = parent
        end
    end

    return dirs
end

local clangd_home = vim.fs.joinpath(vim.fn.stdpath('cache'), 'clangd-home')
local clangd_env = vim.fn.has('win32') == 1 and { USERPROFILE = clangd_home }
    or {
        HOME = clangd_home,
        XDG_CONFIG_HOME = vim.fs.joinpath(clangd_home, '.config'),
    }

local function clangd_config(std)
    return {
        cmd = { 'clangd' },
        cmd_env = clangd_env,
        root_dir = function(bufnr, on_dir)
            on_dir(find_project_root(vim.api.nvim_buf_get_name(bufnr)))
        end,
        init_options = {
            fallbackFlags = {},
        },
        before_init = function(params, config)
            local fname = vim.api.nvim_buf_get_name(0)
            local root

            if params.workspaceFolders and params.workspaceFolders[1] then
                root = vim.uri_to_fname(params.workspaceFolders[1].uri)
            elseif params.rootUri and params.rootUri ~= vim.NIL then
                root = vim.uri_to_fname(params.rootUri)
            end
            root = root or find_project_root(fname)

            local flags = {}
            if std then
                table.insert(flags, '-std=' .. std)
            end
            for _, dir in ipairs(include_dirs(root, fname)) do
                vim.list_extend(flags, { '-I', dir })
            end
            vim.list_extend(config.init_options.fallbackFlags, flags)
        end,
    }
end

return {
    'neovim/nvim-lspconfig',
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    config = function()
        vim.lsp.config('ts_ls', {
            filetypes = {
                'vue',
                'typescript',
                'javascript',
            },
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vim.fn.expand(
                            vim.fn.stdpath('data')
                                .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
                        ),
                        languages = { 'vue' },
                    },
                },
            },
        })

        vim.lsp.config('vue_ls', {
            filetypes = {
                'vue',
                'typescript',
                'javascript',
            },
        })

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })

        vim.lsp.config('clangd', clangd_config('c++2d'))
        vim.lsp.config('clangd_c', clangd_config(nil))
        vim.lsp.enable('clangd_c')
    end,
}
