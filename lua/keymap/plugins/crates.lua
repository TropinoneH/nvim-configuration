local bind = require("keymap.bind")
local map_callback = bind.map_callback

local crates_keymap = {
    ["n|<leader>Ct"] = map_callback(function()
            require("crates").toggle()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Toggle spec activities"),
    ["n|<leader>Cr"] = map_callback(function()
            require("crates").reload()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Reload crate specs"),

    ["n|<leader>Cs"] = map_callback(function()
            require("crates").show_popup()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Toggle pop-up window"),
    ["n|<leader>Cv"] = map_callback(function()
            require("crates").show_versions_popup()
            require("crates").show_popup()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Select spec versions"),
    ["n|<leader>Cf"] = map_callback(function()
            require("crates").show_features_popup()
            require("crates").show_popup()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Select spec features"),
    ["n|<leader>Cd"] = map_callback(function()
            require("crates").show_dependencies_popup()
            require("crates").show_popup()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Show project dependencies"),

    ["n|<leader>Cu"] = map_callback(function()
            require("crates").update_crate()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Update current crate's spec"),
    ["v|<leader>Cu"] = map_callback(function()
            require("crates").update_crates()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Update selected crate's spec"),
    ["n|<leader>Ca"] = map_callback(function()
            require("crates").update_all_crates()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Update all crates' specs"),
    ["n|<leader>CU"] = map_callback(function()
            require("crates").upgrade_crate()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Upgrade current crate"),
    ["v|<leader>CU"] = map_callback(function()
            require("crates").upgrade_crates()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Upgrade selected crates"),
    ["n|<leader>CA"] = map_callback(function()
            require("crates").upgrade_all_crates()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Upgrade all crates"),

    ["n|<leader>CH"] = map_callback(function()
            require("crates").open_homepage()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Open current crate's homepage"),
    ["n|<leader>CR"] = map_callback(function()
            require("crates").open_repository()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Open current crate's repository"),
    ["n|<leader>CD"] = map_callback(function()
            require("crates").open_documentation()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Open current crate's documentation"),
    ["n|<leader>CC"] = map_callback(function()
            require("crates").open_crates_io()
        end)
        :with_noremap()
        :with_silent()
        :with_buffer(0)
        :with_desc("crates: Browse current crate on crates.io"),
}

bind.nvim_load_mapping(crates_keymap)