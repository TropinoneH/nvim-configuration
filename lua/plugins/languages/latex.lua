return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "latex" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "latexindent", "texlab" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = { server = { texlab = {} } },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = { formatters_by_ft = { latex = { "latexindent" } } },
    },
}
