return {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "User LoadColorSchemes",
    opts = {
        transparent_background = true,
        integrations = {
            alpha = true,
            cmp = true,
            gitsigns = true,
            indent_blankline = { enabled = true },
            mason = true,
            mini = true,
            navic = { enabled = true },
            notify = true,
            neotree = true,
            telescope = {
                enabled = true
            },
            treesitter = true,
            which_key = true,
            noice = true,
            lsp_trouble = true,
        },

    }
}