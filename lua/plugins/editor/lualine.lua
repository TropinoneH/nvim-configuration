-- status bar
return {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
        local icons = {
            diagnostics = require("config.icons").get("diagnostics", true),
            git = require("config.icons").get("git", true),
            git_nosep = require("config.icons").get("git"),
            misc = require("config.icons").get("misc", true),
            ui = require("config.icons").get("ui", true),
        }

        local function custom_theme()
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("LualineColorScheme", { clear = true }),
                pattern = "*",
                callback = function()
                    require("lualine").setup({ options = { theme = custom_theme() } })
                end,
            })
            return require("utils.color").get_lualine_theme()
        end

        local mini_sections = {
            lualine_a = { "filetype" },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        }
        local outline = {
            sections = mini_sections,
            filetypes = { "aerial" },
        }
        local diffview = {
            sections = mini_sections,
            filetypes = { "DiffviewFiles" },
        }

        local conditionals = {
            has_enough_room = function()
                return vim.o.columns > 100
            end,
            has_comp_before = function()
                return vim.bo.filetype ~= ""
            end,
            has_git = function()
                local gitdir = vim.fs.find(".git", {
                    limit = 1,
                    upward = true,
                    type = "directory",
                    path = vim.fn.expand("%:p:h"),
                })
                return #gitdir > 0
            end,
        }

        ---@class lualine_hlgrp
        local utils = {
            force_centering = function()
                return "%="
            end,
            abbreviate_path = function(path)
                local home = require("config.global").home
                if path:find(home, 1, true) == 1 then
                    path = "~" .. path:sub(#home + 1)
                end
                return path
            end,
        }

        local function diff_source()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
                return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                }
            end
        end

        local components = {
            separator = { -- use as section separators
                function()
                    return "│"
                end,
                padding = 0,
            },

            file_status = {
                function()
                    local function is_new_file()
                        local filename = vim.fn.expand("%")
                        return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
                    end

                    local symbols = {}
                    if vim.bo.modified then
                        table.insert(symbols, "[+]")
                    end
                    if vim.bo.modifiable == false then
                        table.insert(symbols, "[-]")
                    end
                    if vim.bo.readonly == true then
                        table.insert(symbols, "[RO]")
                    end
                    if is_new_file() then
                        table.insert(symbols, "[New]")
                    end
                    return #symbols > 0 and table.concat(symbols, "") or ""
                end,
                padding = { left = -1, right = 1 },
                cond = conditionals.has_comp_before,
            },

            lsp = {
                function()
                    local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
                    local clients = vim.lsp.get_clients()
                    local lsp_lists = {}
                    local available_servers = {}
                    if next(clients) == nil then
                        return icons.misc.NoActiveLsp -- No server available
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        local client_name = client.name
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            -- Avoid adding servers that already exists.
                            if not lsp_lists[client_name] then
                                lsp_lists[client_name] = true
                                table.insert(available_servers, client_name)
                            end
                        end
                    end
                    return next(available_servers) == nil and icons.misc.NoActiveLsp
                        or string.format("%s[%s]", icons.misc.LspAvailable, table.concat(available_servers, ", "))
                end,
                cond = conditionals.has_enough_room,
            },

            python_venv = {
                function()
                    local function env_cleanup(venv)
                        if venv == vim.fn.expand("$HOME") .. "/miniconda3" or venv == vim.fn.expand("$HOME") .. "/anaconda3" then
                            return "base"
                        end
                        if string.find(venv, "/") then
                            local final_venv = venv
                            for w in venv:gmatch("([^/]+)") do
                                final_venv = w
                            end
                            venv = final_venv
                        end
                        return venv
                    end

                    if vim.api.nvim_get_option_value("filetype", { scope = "local" }) == "python" then
                        local venv = os.getenv("CONDA_PREFIX")
                        if venv then
                            return icons.misc.PyEnv .. env_cleanup(venv)
                        end
                        venv = os.getenv("VIRTUAL_ENV")
                        if venv then
                            return icons.misc.PyEnv .. env_cleanup(venv)
                        end
                    end
                    return ""
                end,
                cond = conditionals.has_enough_room,
            },

            tabwidth = {
                function()
                    return icons.ui.Tab .. vim.api.nvim_get_option_value("shiftwidth", { scope = "local" })
                end,
                padding = 1,
            },

            cwd = {
                function()
                    return icons.ui.FolderWithHeart .. utils.abbreviate_path(vim.fs.normalize(vim.fn.getcwd()))
                end,
            },

            file_location = {
                function()
                    local cursorline = vim.fn.line(".")
                    local cursorcol = vim.fn.virtcol(".")
                    local filelines = vim.fn.line("$")
                    local position
                    if cursorline == 1 then
                        position = "Top"
                    elseif cursorline == filelines then
                        position = "Bot"
                    else
                        position = string.format("%2d%%%%", math.floor(cursorline / filelines * 100))
                    end
                    return string.format("%s · %3d:%-2d", position, cursorline, cursorcol)
                end,
            },
        }

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = custom_theme(),
                disabled_filetypes = { statusline = { "alpha", "snacks_dashboard" } },
                component_separators = "",
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "filetype",
                        colored = true,
                        icon_only = false,
                        icon = { align = "left" },
                    },
                    components.file_status,
                    vim.tbl_extend("force", components.separator, {
                        cond = function()
                            return conditionals.has_git() and conditionals.has_comp_before()
                        end,
                    }),
                },
                lualine_c = {
                    {
                        "branch",
                        icon = icons.git_nosep.Branch,
                        cond = conditionals.has_git,
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.Add,
                            modified = icons.git.Mod_alt,
                            removed = icons.git.Remove,
                        },
                        source = diff_source,
                        colored = false,
                        cond = conditionals.has_git,
                        padding = { right = 1 },
                    },
                    { "overseer" },

                    { utils.force_centering },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        sections = { "error", "warn", "info", "hint" },
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warning,
                            info = icons.diagnostics.Information,
                            hint = icons.diagnostics.Hint_alt,
                        },
                    },
                    components.lsp,
                },
                lualine_x = {
                    {
                        "encoding",
                        fmt = string.upper,
                        padding = { left = 1 },
                        cond = conditionals.has_enough_room,
                    },
                    {
                        "fileformat",
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR", -- Legacy macOS
                        },
                        padding = { left = 1 },
                    },
                    components.tabwidth,
                },
                lualine_y = {
                    components.separator,
                    components.python_venv,
                    components.cwd,
                },
                lualine_z = { components.file_location },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {
                "quickfix",
                "nvim-tree",
                "nvim-dap-ui",
                "fugitive",
                outline,
                diffview,
            },
        })
    end,
}
