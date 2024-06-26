-- select window and just return the bufnr (useless)
return {
    {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        lazy = true,
        event = "VeryLazy",
        opts = { picker_config = { statusline_winbar_picker = { use_winbar = "smart" } } },
        config = function(_, opts)
            require("window-picker").setup(opts)
        end,
    },
    {
        "catppuccin",
        optional = true,
        ---@type CatppuccinOptions
        opts = { integrations = { window_picker = true } },
    },
}
