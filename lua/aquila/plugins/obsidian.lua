return {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Notes/aquila-notes/*.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Notes/aquila-notes/*.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "aquila-notes",
                path = "~/Notes/aquila-notes",
            },
        },
    },
}