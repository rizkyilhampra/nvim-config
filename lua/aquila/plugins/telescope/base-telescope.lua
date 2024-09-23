return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = function()
        local actions = require('telescope.actions')

        return {
            defaults = {
                preview = {
                    filesize_limit = 0.1, -- MB
                },
                mappings = {
                    n = {
                        ['q'] = actions.close,
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                    },
                    i = {
                        ["<ESC>"] = actions.close,
                    }
                }
            },
            extensions = {
                frecency = {
                    show_filter_column = false,
                    db_safe_mode = false,
                    matcher = "fuzzy"
                }
            }
        }
    end,
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)

        telescope.load_extension('fzf')
        telescope.load_extension("neoclip")
    end,
    cmd = "Telescope",
    keys = {
        {
            "<Leader>fF",
            function()
                require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
                    preview = {
                        filesize_limit = 0.1, -- MB
                    },
                    path_display = { filename_first = { reverse_directories = false } },
                    find_command = { "rg", "--files", "--color", "never", "--hidden", "--glob", "!.git" },
                }))
            end,
            desc = "Find files with Telescope picker builtin (rg)"
        },
        {
            "<Leader><Tab>",
            function()
                require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown({
                    previewer = false,
                    initial_mode = 'normal',
                    only_cwd = true,
                    path_display = { filename_first = { reverse_directories = false } },
                }))
            end,
            desc = "List previously open files cwd"
        },
        {
            '<leader>fa',
            function()
                require('telescope.builtin').find_files({
                    no_ignore = true,
                    hidden = true,
                    layout_config = {
                        preview_width = 0.60,
                    }

                })
            end,
            desc = "Find all without respect anything"
        },
        {
            "<leader>fr",
            function()
                require('telescope.builtin').oldfiles({ initial_mode = 'normal' })
            end,
            desc = "List previously open files all dir"

        },
        {
            "<Leader>fS",
            function()
                require('telescope.builtin').live_grep()
            end,
            desc = "Find string in cwd"
        },
        {
            "<leader>fs",
            function()
                require('telescope.builtin').grep_string()
            end,
            desc = "Find string under cursor in cwd"
        },
        {
            "<leader>fb",
            function()
                require('telescope.builtin').buffers({ initial_mode = 'normal' })
            end,
            desc = "list of buffers"
        },
        {
            "<leader>flr",
            function()
                require('telescope.builtin').lsp_references({ initial_mode = 'normal' })
            end,
            desc = "List of references"

        },
        {
            "<leader>fls",
            function()
                require('telescope.builtin').lsp_document_symbols()
            end,
            desc = "List of symbols"

        },
        {
            "<leader>flw",
            "<cmd> lua require('telescope.builtin').lsp_workspace_symbols({initial_mode = 'normal'})<CR> ",

            desc = "List of workspace symbols"

        },
        {
            "<leader>flS",
            function()
                require('telescope.builtin').lsp_dynamic_workspace_symbols()
            end,
            desc = "List of dynamic workspace symbols"
        },
        {
            "<leader>fldd",
            function()
                require('telescope.builtin').diagnostics({ bufnr = 0, initial_mode = 'normal' })
            end,
            desc = "List of diagnostics document"
        },
        {
            "<leader>flii",
            "<cmd> lua require('telescope.require('telescope.builtin')').lsp_implementations({initial_mode = 'normal'})<CR> ",
            desc = "List of implementations"
        },
        {
            "<leader>fldD",
            "<cmd> lua require('telescope.require('telescope.builtin')').lsp_type_definitions({initial_mode = 'normal'})<CR> ",
            desc = "List of type definitions"
        },
        {
            "<leader>fh",
            function()
                require('telescope.builtin').help_tags({
                    attach_mappings = function(prompt_bufnr)
                        local actions = require('telescope.actions')
                        local action_state = require('telescope.actions.state')
                        local action_set = require('telescope.actions.set')
                        local utils = require('telescope.utils')

                        action_set.select:replace(function(_, cmd)
                            local selection = action_state.get_selected_entry()
                            if selection == nil then
                                utils.__warn_no_selection "builtin.help_tags"
                                return
                            end

                            actions.close(prompt_bufnr)
                            if cmd == "default" or cmd == "horizontal" then
                                vim.cmd("FloatingHelp " .. selection.value)
                            elseif cmd == "vertical" then
                                vim.cmd("vert help " .. selection.value)
                            elseif cmd == "tab" then
                                vim.cmd("tab help " .. selection.value)
                            end
                        end)

                        return true
                    end,
                })
            end,
            desc = "List of help tags"

        },
        {
            "<Leader>f/",
            function()
                require('telescope.builtin').resume()
            end,
            desc = "Resume last telescope"
        },
        {
            "<Leader>fi",
            function()
                require('telescope.builtin').highlights()
            end,
            desc = "Lists all available highlights"

        },
        {
            "<Leader>fC",
            function()
                require('aquila.config.telescope.filepath').list_paths()
            end,
            desc = "List of paths"
        },
    },
}