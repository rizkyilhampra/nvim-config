return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
        },
        scope = {
            enabled = false
        }
    }
}