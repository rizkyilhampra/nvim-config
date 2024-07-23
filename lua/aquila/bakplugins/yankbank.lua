return {
    "ptdewey/yankbank-nvim",
    keys = {
        {
            "<Leader>Y",
            "<cmd>YankBank<CR>",
            desc = "List clipboard history",
        }
    },
    opts = {
        max_entries = 12,
        sep = "",
        keymaps = {
            navigation_next = "j",
            navigation_prev = "k",
        },
    }
}