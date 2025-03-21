return {
    {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "python", "toml" })
            end
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        optional = true,
        opts = function(_, opts)
            if opts.ensure_installed ~= "all" then
                opts.ensure_installed = require("utils.core").list_insert_unique(opts.ensure_installed, { "pyright", "black", "isort", "debugpy" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            server = {
                pyright = {
                    filetypes = { "python" },
                    before_init = function(_, config)
                        local path = vim.fn.exepath("python")
                        local sep = require("config.global").is_windows and "\\" or "/"
                        local conda_prefix = vim.env.CONDA_PREFIX
                        local venv_prefix = vim.env.VIRTUAL_ENV
                        if conda_prefix ~= nil and conda_prefix ~= "" then
                            path = conda_prefix .. sep .. "bin" .. sep .. "python"
                        elseif venv_prefix ~= nil and venv_prefix ~= "" then
                            path = venv_prefix .. sep .. "bin" .. sep .. "python"
                        end

                        config.settings.python.pythonPath = path
                    end,
                },
            },
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        cmd = "VenvSelect",
        branch = "regexp",
        enabled = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 or vim.fn.executable("fd-find") == 1,
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = {},
        ft = "python",
        keys = {
            { "<leader>vs", "<Cmd>VenvSelect<CR>", desc = "Select Python Virtual Environment" },
            {
                "<leader>vd",
                function()
                    require("venv-selector").deactivate()
                end,
                desc = "Deactivate Python Virtual Environment",
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                python = { "isort", "black" },
            },
            formatters = {
                black = { args = { "--stdin-filename", "$FILENAME", "--line-length", 160, "--quiet", "-" } },
                isort = { prepend_args = { "-l", 160 } },
            },
        },
    },
}
