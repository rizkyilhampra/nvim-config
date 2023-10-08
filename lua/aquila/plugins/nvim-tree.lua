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
                width = 35,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
        }

        function find_directory_and_focus()
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            local function open_nvim_tree(prompt_bufnr, _)
                actions.select_default:replace(function()
                    local api = require("nvim-tree.api")

                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    api.tree.open()
                    api.tree.find_file(selection.cwd .. "/" .. selection.value)
                    api.node.open.edit()
                end)
                return true
            end

            require("telescope.builtin").find_files({
                attach_mappings = open_nvim_tree
            })
        end

        vim.keymap.set("n", "ff", find_directory_and_focus, { desc = "open directory" })
        vim.keymap.set("n", "<Leader><Space>", find_directory_and_focus, { desc = "open directory" })
    end,
}
