-- scroll bar and show diagnostics in scrollview
return {
    "dstein64/nvim-scrollview",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
        local icons = { diagnostics = require("config.icons").get("diagnostics", true) }

        require("scrollview").setup({
            mode = "virtual",
            excluded_filetypes = { "NvimTree", "terminal", "nofile", "aerial" },
            winblend = 0,
            signs_on_startup = { "diagnostics", "folds", "marks", "search", "spell" },
            diagnostics_error_symbol = icons.diagnostics.Error,
            diagnostics_warn_symbol = icons.diagnostics.Warning,
            diagnostics_info_symbol = icons.diagnostics.Information,
            diagnostics_hint_symbol = icons.diagnostics.Hint,
        })
    end,
}
