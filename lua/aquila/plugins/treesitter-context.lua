return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User BaseFile",
    keys = {
        {
            "<Leader>ct",
            ':TSContextToggle<CR>',
            desc = "Toggle treesitter context"
        }
    },
}