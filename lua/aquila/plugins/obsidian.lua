return {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    enabled = false,
    event = "VeryLazy",
    opts = {
        workspaces = {
            {
                name = "aquila",
                path = "~/Notes/aquila-notes/",
            },
        },
    }
}
