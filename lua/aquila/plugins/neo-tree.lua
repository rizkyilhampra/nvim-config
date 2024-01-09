return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                width = 35,
            },
            filesystem = {
                follow_current_file = {
                    enabled         = true,
                    leave_dirs_open = true
                },
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                        ".git"
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db"
                    },
                },
            },
        })

        vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end
}
