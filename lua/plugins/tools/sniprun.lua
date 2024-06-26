-- quick run code
return {
    "michaelb/sniprun",
    lazy = true,
    -- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
    -- if you encountered error about no executable sniprun found.
    build = "bash ./install.sh",
    cmd = { "SnipRun", "SnipReset", "SnipInfo" },
    config = function()
        local function is_empty(s)
            return s == nil or s == ""
        end

        local function get_python_env()
            local venv = vim.env.CONDA_PREFIX
            if not is_empty(venv) then
                return venv .. "/bin/python"
            end
            if not is_empty(vim.env.VIRTUAL_ENV) then
                return vim.env.VIRTUAL_ENV .. "/bin/python"
            end
        end

        require("sniprun").setup({
            selected_interpreters = {
                get_python_env(),
            }, -- " use those instead of the default for the current filetype
            repl_enable = {}, -- " enable REPL-like behavior for the given interpreters
            repl_disable = {}, -- " disable REPL-like behavior for the given interpreters
            interpreter_options = {}, -- " intepreter-specific options, consult docs / :SnipInfo <name>
            -- " you can combo different display modes as desired
            display = {
                "TempFloatingWindowOk", -- display ok results in the floating window
                "NvimNotifyErr", -- display err results with the nvim-notify plugin
                -- "Classic", -- display results in the command line"
                -- "VirtualText", -- display results in virtual text"
                -- "LongTempFloatingWindow", -- display results in the long floating window
                -- "Terminal" -- display results in a vertical split
                -- "TerminalWithCode" -- display results and code history in a vertical split
            },
            display_options = {
                terminal_width = 45,
                notification_timeout = 5000,
            },
            -- " miscellaneous compatibility/adjustement settings
            inline_messages = 0, -- " inline_message (0/1) is a one-line way to display messages
            -- " to workaround sniprun not being able to display anything
            borders = "single", -- " display borders around floating windows
            -- " possible values are 'none', 'single', 'double', or 'shadow'
        })
    end,
}
