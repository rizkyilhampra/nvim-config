return {
    "saecki/live-rename.nvim",
    keys = {
        {
            "<Leader>r",
            "<cmd>lua require('live-rename').rename()<CR>",
            desc = "Rename symbol under cursor"
        }
    }
}