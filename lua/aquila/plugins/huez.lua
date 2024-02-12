-- allows users to preview and select color schemes using Telescope, and save their selection persistently through sessions.
return {
    "vague2k/huez.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
        -- You probably already have this installed.
        -- reccomended, but optional dependency.
        -- Will use vim.ui as a default unless specified otherwise, or a fallback.
        -- Preview does not currently work in vim.ui.
        "nvim-telescope/telescope.nvim",
    },
}
