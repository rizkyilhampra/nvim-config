return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            search = {
                enabled = false
            },
            char = {
                keys = { "f", "F", "t", "T" },
            }
        }
    },
    keys = {
        { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
}
