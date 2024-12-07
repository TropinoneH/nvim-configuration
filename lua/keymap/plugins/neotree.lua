local bind = require("keymap.bind")
local map_cr = bind.map_cr

bind.nvim_load_mapping({
    ["n|<leader>e"] = map_cr("Neotree toggle float"):with_noremap():with_silent():with_nowait():with_desc("Neotree: Toggle float window"),
    ["n|<leader>ne"] = map_cr("Neotree toggle left"):with_noremap():with_silent():with_nowait():with_desc("Neotree: Toggle left side window"),
    ["n|<leader>nf"] = map_cr("Neotree focus"):with_noremap():with_silent():with_nowait():with_desc("Neotree: Focus window"),
    ["n|<leader>ng"] = map_cr("Neotree float git_status"):with_noremap():with_silent():with_nowait():with_desc("Neotree: Open float git status window"),
    ["n|<leader>nb"] = map_cr("Neotree float buffers"):with_noremap():with_silent():with_nowait():with_desc("Neotree: Open float opened buffers"),
    ["n|<leader>nl"] = map_cr("Neotree float document_symbols"):with_noremap():with_silent():with_nowait():with_desc("Neotree: Open float document symbols"),
    ["n|<leader>n<CR>"] = map_cr("Neotree toggle float last"):with_noremap():with_silent():with_nowait():with_desc("Neotree: Reopen last window"),
})
