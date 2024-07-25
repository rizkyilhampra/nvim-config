return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>o",
            "<cmd>lua require('oil').toggle_float()<CR>",
            desc = "Toggle Oil"
        }
    },
    opts = {
        view_options = {
            show_hidden = true,
        },
        float = {
            padding = 2,
            max_width = 90,
            max_height = 0,
            win_options = {
                winblend = 0,
            }
        },
    },
    enabled = false
}