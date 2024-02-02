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
            use_libuv_file_watcher = true,
            window = {
                width = 35,
                mappings = {
                    ["h"] = function(state)
                        local node = state.tree:get_node()
                        if node.type == 'directory' and node:is_expanded() then
                            require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
                        else
                            require 'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
                        end
                    end,
                    ["l"] = function(state)
                        local node = state.tree:get_node()
                        if node.type == 'directory' then
                            if not node:is_expanded() then
                                require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
                            elseif node:has_children() then
                                require 'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
                            end
                        elseif node.type == 'file' then
                            require("neo-tree.sources.filesystem.commands").open(state)
                        end
                    end,
                    -- copy to system clipboard
                    ["Y"] = function(state)
                        local currentNode = state.tree:get_node()
                        local path = currentNode.path
                        vim.fn.setreg("+", path)
                        vim.notify("Copied to system clipboard", "info", {
                            title = "NeoTree",
                            timeout = 1000,
                        })
                    end,
                    -- paste from system clipboard
                    ["P"] = function(state)
                        local clipboardPath = vim.fn.getreg("+")

                        if clipboardPath == "" then return end

                        local currentNode = state.tree:get_node()
                        local inputs = require("neo-tree.ui.inputs")
                        local confirmationMessage = "Are you sure you want to paste " .. clipboardPath

                        inputs.confirm(confirmationMessage, function(confirmed)
                            if not confirmed then return end

                            local success, error = pcall(function()
                                local sourcePath = vim.fn.fnameescape(clipboardPath)
                                local destinationPath = vim.fn.fnameescape(currentNode.path)

                                if currentNode.type == 'directory' then
                                    vim.fn.system { "cp", "-r", sourcePath, destinationPath }
                                elseif currentNode.type == 'file' then
                                    vim.fn.system { "cp", sourcePath, destinationPath }
                                end
                            end)

                            if not success then
                                local errorNotification = {
                                    title = "NeoTree",
                                    timeout = 1000,
                                }
                                vim.notify("Failed to paste from system clipboard", "error", errorNotification)
                                vim.cmd [[echohl ErrorMsg]]
                                return
                            end

                            -- reset clipboard
                            vim.fn.setreg("+", "")

                            require("neo-tree.sources.manager").refresh(state.name)
                            require 'neo-tree.ui.renderer'.focus_node(state, currentNode.id)

                            local successNotification = {
                                title = "NeoTree",
                                timeout = 1000,
                            }
                            vim.notify("Pasted from system clipboard", "info", successNotification)
                        end)
                    end

                }
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
                commands = {
                    delete = function(state)
                        local inputs = require("neo-tree.ui.inputs")
                        local path = state.tree:get_node().path
                        local msg = "Are you sure you want to trash " .. path
                        inputs.confirm(msg, function(confirmed)
                            if not confirmed then return end

                            local success, error = pcall(function()
                                vim.fn.system { "trash", vim.fn.fnameescape(path) }
                            end)

                            if not success then
                                local errorNotification = {
                                    title = "NeoTree",
                                    timeout = 1000,
                                }
                                vim.notify("Failed to delete to trash", "error", errorNotification)

                                msg = "Skip trash? (permanent delete)"

                                inputs.confirm(msg, function(confirmed)
                                    if not confirmed then return end

                                    if state.tree:get_node().type == "directory" then
                                        vim.fn.system { "rm", "-rf", vim.fn.fnameescape(path) }
                                    else
                                        vim.fn.system { "rm", vim.fn.fnameescape(path) }
                                    end
                                end)
                            end
                            require("neo-tree.sources.manager").refresh(state.name)
                        end)
                    end,

                    -- currently i'm not using this, but it's a good example of how to override default commands
                    -- over write default 'delete_visual' command to 'trash' x n.
                    -- delete_visual = function(state, selected_nodes)
                    --     local inputs = require("neo-tree.ui.inputs")
                    --
                    --     -- get table items count
                    --     function GetTableLen(tbl)
                    --         local len = 0
                    --         for n in pairs(tbl) do
                    --             len = len + 1
                    --         end
                    --         return len
                    --     end
                    --
                    --     local count = GetTableLen(selected_nodes)
                    --     local msg = "Are you sure you want to trash " .. count .. " files ?"
                    --     inputs.confirm(msg, function(confirmed)
                    --         if not confirmed then return end
                    --         for _, node in ipairs(selected_nodes) do
                    --             vim.fn.system { "trash", vim.fn.fnameescape(node.path) }
                    --         end
                    --         require("neo-tree.sources.manager").refresh(state.name)
                    --     end)
                    -- end,
                }
            },
        })

        vim.keymap.set("n", "<Leader>e", '<cmd>Neotree toggle<CR>')
        vim.keymap.set("n", "<Leader>E", '<cmd>Neotree reveal<CR>')
    end
}
