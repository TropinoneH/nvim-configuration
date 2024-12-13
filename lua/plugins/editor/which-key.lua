-- cheatsheet for keybindings
return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local icons = {
                ui = require("config.icons").get("ui"),
                misc = require("config.icons").get("misc"),
                git = require("config.icons").get("git", true),
                cmp = require("config.icons").get("cmp", true),
            }
            require("which-key").add({
                { "<leader>b", group = icons.ui.Buffer .. " Buffer" },
                { "<leader>bs", group = icons.ui.Sort .. " Buffer Sort" },
                { "<leader>C", group = icons.misc.Gavel .. " Crates" },
                { "<leader>d", group = icons.ui.Bug .. " Debug" },
                { "<leader>f", group = icons.ui.Telescope .. " Fuzzy Find" },
                { "<leader>g", group = icons.git.Git .. " Git" },
                { "<leader>l", group = icons.misc.LspAvailable .. " Lsp" },
                { "<leader>n", group = icons.ui.FolderOpen .. " NeoTree" },
                { "<leader>p", group = icons.ui.Package .. " Package" },
                { "<leader>s", group = icons.cmp.tmux .. "Session" },
                { "<leader>t", group = icons.ui.Terminal .. " Terminal" },
                { "<leader>T", group = icons.ui.Tasks .. " Tasks" },
                { "<leader>w", group = icons.misc.ManUp .. " Window" },
                { "<leader>u", group = icons.ui.Window .. " UI" },
                { "<leader>x", group = icons.ui.Trouble .. " Trouble" },
                { "<leader>o", group = icons.ui.Tasks .. " Overseer" },
            })
            require("which-key").setup({
                plugins = {
                    presets = {
                        operators = false,
                        motions = false,
                        text_objects = false,
                        windows = false,
                        nav = false,
                        z = true,
                        g = true,
                    },
                },

                icons = {
                    breadcrumb = icons.ui.Separator,
                    separator = icons.misc.Vbar,
                    group = ""
                },

                disable = { filetypes = { "TelescopePrompt" } },
            })
        end,
    },
}
