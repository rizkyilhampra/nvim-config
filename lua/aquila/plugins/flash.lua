return {
    "folke/flash.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
}