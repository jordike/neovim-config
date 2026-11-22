return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        local mason_registry = require('mason-registry')

        local function get_lsp_root(client_name)
            local clients = vim.lsp.get_clients({
                bufnr = vim.api.nvim_get_current_buf(),
                name = client_name,
            })

            for _, client in ipairs(clients) do
                if client.root_dir then
                    return client.root_dir
                end
            end

            vim.notify('No ' .. client_name .. ' project root found', vim.log.levels.ERROR)

            return nil
        end

        local function mason_package_path(package)
            return mason_registry.get_package(package):get_install_path()
        end

        local function mason_bin(name)
            local path = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin', name)

            if vim.fn.has('win32') == 1 then
                path = path .. '.cmd'
            end

            return path
        end

        local function find_cpp_executable()
            local root = get_lsp_root('clangd')

            if not root then
                return nil
            end

            local build_dir = vim.fs.joinpath(root, 'build')

            local executables = vim.fs.find(function(name)
                return name:match('%.exe$') ~= nil
            end, {
                path = build_dir,
                type = 'file',
            })

            if #executables == 0 then
                vim.notify('No executable found in ' .. build_dir, vim.log.levels.ERROR)

                return nil
            end

            if #executables == 1 then
                return executables[1]
            end

            local choices = { 'Select executable:' }

            for i, executable in ipairs(executables) do
                choices[i + 1] = string.format('%d. %s', i, vim.fs.relpath(build_dir, executable))
            end

            local choice = vim.fn.inputlist(choices)

            if choice < 1 or choice > #executables then
                return nil
            end

            return executables[choice]
        end

        local function find_dotnet_executable()
            local root = get_lsp_root('omnisharp_mono')

            if not root then
                return nil
            end

            local bin_dir = vim.fs.joinpath(root, 'bin')

            local files = vim.fs.find(function(name)
                return name:match('%.dll$') ~= nil
            end, {
                path = bin_dir,
                type = 'file',
            })

            if #files == 0 then
                vim.notify('No .NET executable found in ' .. bin_dir, vim.log.levels.ERROR)

                return nil
            end

            if #files == 1 then
                return files[1]
            end

            local choices = { 'Select .NET executable:' }

            for i, file in ipairs(files) do
                choices[i + 1] = string.format('%d. %s', i, vim.fs.relpath(bin_dir, file))
            end

            local choice = vim.fn.inputlist(choices)

            if choice < 1 or choice > #files then
                return nil
            end

            return files[choice]
        end

        local codelldb_path = vim.fs.joinpath(mason_package_path('codelldb'), 'extension', 'adapter', 'codelldb.exe')

        dap.adapters.codelldb = {
            type = 'executable',
            command = codelldb_path,
        }

        dap.adapters.netcoredbg = {
            type = 'executable',
            command = mason_bin('netcoredbg'),
            args = { '--interpreter=vscode' },
        }

        dap.adapters.php = {
            type = 'executable',
            command = mason_bin('php-debug-adapter'),
        }

        dap.adapters.dart = {
            type = 'executable',
            command = mason_bin('dart-debug-adapter'),
        }

        dap.configurations.cpp = {
            {
                name = 'Launch',
                type = 'codelldb',
                request = 'launch',
                program = find_cpp_executable,
                cwd = function()
                    return get_lsp_root('clangd')
                end,
                stopOnEntry = false,
            },
        }

        dap.configurations.c = dap.configurations.cpp

        dap.configurations.cs = {
            {
                name = 'Launch',
                type = 'netcoredbg',
                request = 'launch',
                program = find_dotnet_executable,
                cwd = function()
                    return get_lsp_root('omnisharp_mono')
                end,
                stopAtEntry = false,
            },
        }

        dap.configurations.php = {
            {
                name = 'Listen for Xdebug',
                type = 'php',
                request = 'launch',
                port = 9003,
            },
        }

        dap.configurations.dart = {
            {
                name = 'Launch',
                type = 'dart',
                request = 'launch',
                program = '${workspaceFolder}/lib/main.dart',
                cwd = '${workspaceFolder}',
            },
        }

        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        require('nvim-dap-virtual-text').setup()
    end,
    keys = {
        {
            '<leader>db',
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = 'Toggle breakpoint',
        },
        {
            '<leader>dc',
            function()
                require('dap').continue()
            end,
            desc = 'Continue / start debugging',
        },
        {
            '<leader>do',
            function()
                require('dap').step_over()
            end,
            desc = 'Step over',
        },
        {
            '<leader>di',
            function()
                require('dap').step_into()
            end,
            desc = 'Step into',
        },
        {
            '<leader>dO',
            function()
                require('dap').step_out()
            end,
            desc = 'Step out',
        },
        {
            '<leader>dr',
            function()
                require('dap').restart()
            end,
            desc = 'Restart debugging',
        },
        {
            '<leader>dq',
            function()
                require('dap').terminate()
            end,
            desc = 'Terminate debugging',
        },
        {
            '<leader>dt',
            function()
                require('dapui').toggle()
            end,
            desc = 'Toggle DAP UI',
        },
        {
            '<leader>de',
            function()
                require('dapui').eval()
            end,
            mode = { 'n', 'v' },
            desc = 'Evaluate expression',
        },
    },
}
