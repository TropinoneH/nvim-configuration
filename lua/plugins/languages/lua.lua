return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "lua", "luap" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "lua-language-server", "stylua", "selene" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = function(_, opts)
            opts.server = opts.server or {}
            opts.server.lua_ls = {
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {
                                "vim",
                                "require",
                                "Snacks",
                            },
                            disable = { "different-requires" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("config") .. "/lua"] = true,
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000,
                        },
                        hint = {
                            enable = true,
                            arrayIndex = "Disable",
                        },
                        format = { enable = false },
                        telemetry = { enable = false },
                        -- Do not override treesitter lua highlighting with lua_ls's highlighting
                        semantic = { enable = false },
                    },
                },
            }
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "saghen/blink.cmp",
        optional = true,
        opts = function(_, opts)
            opts.sources = opts.sources or { completion = {} }
            local enabled_providers = opts.sources.completion.enabled_providers or {}
            local providers = opts.sources.providers or {}
            opts.sources.completion.enabled_providers = require("utils.core").list_insert_unique(enabled_providers, { "lazydev" })
            opts.sources.providers = vim.tbl_extend("force", providers, {
                -- dont show LuaLS require statements when lazydev has items
                lsp = { fallback_for = { "lazydev" } },
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
            formatters = {
                stylua = {
                    command = "stylua",
                    args = {
                        "--search-parent-directories",
                        "--stdin-filepath",
                        "$FILENAME",
                        "-",
                    },
                    prepend_args = function()
                        local line_end = "Unix"
                        local os_name = (vim.uv or vim.loop).os_uname().sysname
                        if os_name:find("Windows") then
                            line_end = "Windows"
                        end

                        return {
                            "--no-editorconfig",
                            "--column-width",
                            "160",
                            "--line-endings",
                            line_end,
                            "--config-path",
                            vim.fn.stdpath("config") .. "/lua/config/format/stylua.config.toml",
                        }
                    end,
                    range_args = function(_, ctx)
                        local start_offset, end_offset = require("conform.util").get_offsets_from_range(ctx.buf, ctx.range)

                        return {
                            "--search-parent-directories",
                            "--stdin-filepath",
                            "$FILENAME",
                            "--range-start",
                            tostring(start_offset),
                            "--range-end",
                            tostring(end_offset),
                            "-",
                        }
                    end,
                    -- cwd = require("conform.util").root_file({
                    -- ".stylua.toml",
                    -- "stylua.toml",
                    -- }),
                },
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                lua = { "selene" },
            },
        },
    },
}
