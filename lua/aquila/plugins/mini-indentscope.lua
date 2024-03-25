return {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile" }, -- to disable, comment this out
    opts = {
        symbol = "│",
        options = {
            try_as_border = true
        }
    },
}