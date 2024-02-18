return {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = {
        workspaces = {
            {
                name = "aquila",
                path = "~/Notes/aquila-notes/",
            },
            {
                name = "personal-blog",
                path = "~/Projects/obsidian-blog/resources/markdown/articles"
            }
        },
    }
}
