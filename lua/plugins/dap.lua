-- ~/.config/nvim/lua/plugins/dap.lua
return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- DAP UI
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                opts = {},
            },
            -- Virtual text for variables
            { "theHamsta/nvim-dap-virtual-text", opts = {} },
            -- Mason integration: auto-install debug adapters
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = { "mason-org/mason.nvim" },
                opts = {
                    ensure_installed = { "codelldb" },
                    automatic_installation = true,
                },
            },
        },
        keys = {
            { "<F5>",       function() require("dap").continue() end,          desc = "Debug: Continue" },
            { "<F9>",       function() require("dap").toggle_breakpoint() end, desc = "Debug: Breakpoint" },
            { "<F10>",      function() require("dap").step_over() end,         desc = "Debug: Step Over" },
            { "<F11>",      function() require("dap").step_into() end,         desc = "Debug: Step Into" },
            { "<F12>",      function() require("dap").step_out() end,          desc = "Debug: Step Out" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dB", function()
                require("dap").set_breakpoint(vim.fn.input("Condition: "))
            end, desc = "Conditional Breakpoint" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
            { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- ── codelldb adapter (C, C++, Rust) ──
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "codelldb",
                    args = { "--port", "${port}" },
                },
            }

            -- ── C / C++ configurations ──
            for _, lang in ipairs({ "c", "cpp" }) do
                dap.configurations[lang] = {
                    {
                        name = "Launch executable",
                        type = "codelldb",
                        request = "launch",
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                    },
                    {
                        name = "Attach to process",
                        type = "codelldb",
                        request = "attach",
                        pid = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                }
            end

            -- ── Rust configurations ──
            dap.configurations.rust = {
                {
                    name = "Launch executable",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        -- Try to find the binary from cargo build
                        local cwd = vim.fn.getcwd()
                        local target = cwd .. "/target/debug/"
                        return vim.fn.input("Path to executable: ", target, "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            -- Auto open/close DAP UI
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
        end,
    },
}
