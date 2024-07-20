return {
    "cbochs/grapple.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        scope = "git",
    },
    cmd = "Grapple",
    keys = {
        {
            "<Leader>GG", "<cmd>Grapple toggle_tags<CR>", desc = "Grapple toggle tags",
        },
        {
            "<Leader>GA", "<cmd>Grapple toggle<CR>", desc = "Grapple toggle tag"
        }
    }
}