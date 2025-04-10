return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "xml" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "lemminx", "xmlformatter" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = { server = { lemminx = {} } },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                xml = { "xmlformatter" },
            },
            formatters = {
                xmlformatter = {
                    prepend_args = { "--indent", "4" },
                },
            },
        },
    },
}
