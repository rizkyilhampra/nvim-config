return {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    cond = vim.fn.isdirectory("Notes") == 1,
    opts = {
        workspaces = {
            {
                name = "aquila",
                path = "~/Notes/aquila-notes/",
            },
        },
    }
}