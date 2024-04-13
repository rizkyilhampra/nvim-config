return {
    "cbochs/grapple.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons", lazy = true }
    },
    opts = {
        scope = "git", -- also try out "git_branch"
    },
    cmd = "Grapple",
    keys = {
        {
            "<Leader><Tab>", "<cmd>Grapple toggle_tags<CR>", desc = "Grapple toggle tags",
        },
        {
            "<Leader>GG", "<cmd>Grapple toggle<CR>", desc = "Grapple toggle tag"
        }
    }
}