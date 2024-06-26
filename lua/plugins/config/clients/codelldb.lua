-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
return function()
    local dap = require("dap")
    local is_windows = require("config.global").is_windows
    local utils = require("utils.dap")

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = vim.fn.exepath("codelldb"), -- Find codelldb on $PATH
            args = { "--port", "${port}" },
            detached = is_windows and false or true,
        },
    }

    dap.configurations.c = {
        {
            name = "Debug",
            type = "codelldb",
            request = "launch",
            program = utils.input_exec_path(),
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "CMake with CLion format",
            type = "codelldb",
            request = "launch",
            program = utils.input_cmake_exec_path(),
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "Debug (with args)",
            type = "codelldb",
            request = "launch",
            program = utils.input_exec_path(),
            args = utils.input_args(),
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "Attach to a running process",
            type = "codelldb",
            request = "attach",
            program = utils.input_exec_path(),
            stopOnEntry = false,
            waitFor = true,
        },
    }
    dap.configurations.cpp = dap.configurations.c

    dap.configurations.rust = {
        {
            name = "Debug",
            type = "codelldb",
            request = "launch",
            program = utils.input_rust_exec_path(),
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "Debug (with args)",
            type = "codelldb",
            request = "launch",
            program = utils.input_rust_exec_path(),
            args = utils.input_args(),
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            terminal = "integrated",
        },
        {
            name = "Attach to a running process",
            type = "codelldb",
            request = "attach",
            program = utils.input_rust_exec_path(),
            stopOnEntry = false,
            waitFor = true,
        },
    }
end
