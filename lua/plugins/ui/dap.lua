return {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio',
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

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
    end,
    keys = {
        {
            '<leader>dt',
            function()
                require('dapui').toggle()
            end,
            desc = 'Toggle Debug Adapter ui',
        },
        {
            '<leader>df',
            function()
                require('dapui').float_element()
            end,
            desc = 'Toggle Debug Adapter UI floating element window',
        },
        {
            '<leader>de',
            function()
                require('dapui').eval()
            end,
            desc = 'Evaluate the selected expression using DAP',
        },
    },
}
