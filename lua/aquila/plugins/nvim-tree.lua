return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.keymap.set("n", "<Leader>e", vim.cmd.NvimTreeToggle, { desc = 'Toggle explorer' })
        vim.keymap.set("n", "<Leader>E", vim.cmd.NvimTreeFocus, { desc = 'Focus explorer' })
        require("nvim-tree").setup {
            sort_by = "case_sensitive",
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
        }
    end,
}

