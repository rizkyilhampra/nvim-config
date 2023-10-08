return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
