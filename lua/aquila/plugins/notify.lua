return {
    "rcarriga/nvim-notify",
    opts = {
        max_width = math.floor(vim.o.columns * 0.4),
        render = "wrapped-compact",
        timeout = 200
    }
}