return {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    opts = {
        contrast = "hard", -- can be "hard", "soft" or empty string
        transparent_mode = vim.g.aquila_theme_transparent_mode or false,
    },
    config = function(_, opts)
        require('gruvbox').setup(opts)
        vim.o.background = "dark" -- or "light" for light mode
    end,
}
