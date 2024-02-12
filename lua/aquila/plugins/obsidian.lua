return {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    ft = "markdown",
    opts = {
        workspaces = {
            {
                name = "aquila",
                path = "~/Notes/aquila-notes/personal",
            },
            {
                name = "personal-blog",
                path = "~/Projects/obsidian-blog/resources/markdown/articles"
            }
        },
    },

    config = function(_, opts)
        require('obsidian').setup(opts)
    end
}
