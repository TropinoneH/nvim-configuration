-- show indent lines
return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "CursorHold", "CursorHoldI" },
    cmd = {
        "IBLEnable",
        "IBLDisable",
        "IBLToggle",
        "IBLEnableScope",
        "IBLDisableScope",
        "IBLToggleScope",
        "CursorHold",
        "CursorHoldI",
    },
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
            priority = 2,
        },
        whitespace = { remove_blankline_trail = false },
        -- Note: The `scope` field requires treesitter to be set up
        scope = {
            enabled = true,
            char = "┃",
            show_start = false,
            show_end = false,
            priority = 1000,
            include = {
                node_type = {
                    ["*"] = {
                        "argument_list",
                        "arguments",
                        "assignment_statement",
                        "Block",
                        "class",
                        "ContainerDecl",
                        "dictionary",
                        "do_block",
                        "do_statement",
                        "element",
                        "except",
                        "FnCallArguments",
                        "for",
                        "for_statement",
                        "function",
                        "function_declaration",
                        "function_definition",
                        "if_statement",
                        "IfExpr",
                        "IfStatement",
                        "import",
                        "InitList",
                        "list_literal",
                        "method",
                        "object",
                        "ParamDeclList",
                        "repeat_statement",
                        "selector",
                        "SwitchExpr",
                        "table",
                        "table_constructor",
                        "try",
                        "tuple",
                        "type",
                        "var",
                        "while",
                        "while_statement",
                        "with",
                    },
                },
            },
        },
        exclude = {
            filetypes = {
                "", -- for all buffers without a file type
                "aerial",
                "alpha",
                "big_file_disabled_ft",
                "dashboard",
                "dotooagenda",
                "flutterToolsOutline",
                "fugitive",
                "git",
                "gitcommit",
                "help",
                "json",
                "log",
                "markdown",
                "NvimTree",
                "peekaboo",
                "startify",
                "TelescopePrompt",
                "todoist",
                "txt",
                "undotree",
                "vimwiki",
                "vista",
            },
        },
    },
    config = function(_, opts)
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IndentRainbowRed", { fg = "#7a4654" })
            vim.api.nvim_set_hl(0, "IndentRainbowBlue", { fg = "#455a7d" })
            vim.api.nvim_set_hl(0, "IndentRainbowCyan", { fg = "#4a726b" })
            vim.api.nvim_set_hl(0, "IndentRainbowGreen", { fg = "#537251" })
            vim.api.nvim_set_hl(0, "IndentRainbowOrange", { fg = "#7d5a44" })
            vim.api.nvim_set_hl(0, "IndentRainbowViolet", { fg = "#66537c" })
            vim.api.nvim_set_hl(0, "IndentRainbowYellow", { fg = "#7d7158" })
        end)
        local highlight = {
            "IndentRainbowRed",
            "IndentRainbowYellow",
            "IndentRainbowBlue",
            "IndentRainbowOrange",
            "IndentRainbowGreen",
            "IndentRainbowViolet",
            "IndentRainbowCyan",
        }
        opts.indent.highlight = highlight
        opts.scope.highlight = "RainbowDelimiterCyan"
        require("ibl").setup(opts)
    end,
}
