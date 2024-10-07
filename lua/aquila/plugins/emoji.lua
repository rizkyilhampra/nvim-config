return {
    "allaman/emoji.nvim",
    keys = {
        {
            "<leader>fe",
            function()
                require('telescope').extensions.emoji.emoji()
            end,
            desc = "Find emoji"
        }
    },
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    opts = {},
}