return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        -- {
        --     's1n7ax/nvim-window-picker',
        --     version = '2.*',
        --     config = function()
        --         require 'window-picker'.setup({
        --             filter_rules = {
        --                 include_current_win = false,
        --                 autoselect_one = true,
        --                 -- filter using buffer options
        --                 bo = {
        --                     -- if the file type is one of following, the window will be ignored
        --                     filetype = { 'neo-tree', "neo-tree-popup", "notify" },
        --                     -- if the buffer type is one of following, the window will be ignored
        --                     buftype = { 'terminal', "quickfix" },
        --                 },
        --             },
        --         })
        --     end,
        -- },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                width = 35,
            },
            buffers = {
                follow_current_file = {
                    enabled = true
                }
            },
            filesystem = {
                follow_current_file = {
                    enabled = true
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
    end
}
