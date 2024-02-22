return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local themes = require('telescope.themes')
        local builtin = require('telescope.builtin')

        telescope.load_extension("smart_open")

        telescope.setup({
            defaults = {
                mappings = {
                    n = {
                        ['q'] = actions.close
                    }
                },
            },
        })

        vim.keymap.set('n', '<leader>fa', function()
                builtin.find_files({
                    no_ignore = true,
                    hidden = true,
                })
            end,
            { desc = "Find all without respect anything" }
        )

        vim.keymap.set("n", "<leader>fr", function()
                builtin.oldfiles({ initial_mode = 'normal' })
            end,
            { desc = "List previously open files all dir" }
        )

        vim.keymap.set("n", "<leader><Tab>", function()
                builtin.oldfiles(themes.get_dropdown({
                    previewer = false,
                    initial_mode = 'normal',
                    cwd_only = true,
                }))
            end,
            { desc = 'List previously open files on cwd' }
        )

        vim.keymap.set("n", "<leader>fs", function()
            builtin.live_grep()
        end, { desc = "Find string in cwd" })

        vim.keymap.set("n", "<leader>fc", function()
                builtin.grep_string()
            end,
            { desc = "Find string under cursor in cwd" }
        )

        vim.keymap.set("n", "<leader>fb", function()
                builtin.buffers({ initial_mode = 'normal' })
            end,
            { desc = "list of buffers" }
        )

        vim.keymap.set('n', "<leader>flr", function()
                builtin.lsp_references({ initial_mode = 'normal' })
            end,
            { desc = "List of references" }
        )

        vim.keymap.set('n', "<leader>fls", function()
                builtin.lsp_document_symbols()
            end,
            { desc = "List of symbols" }
        )

        vim.keymap.set('n', "<leader>flw",
            "<cmd> lua require('telescope.builtin').lsp_workspace_symbols({initial_mode = 'normal'})<CR> ", {
                desc = "List of workspace symbols"
            }
        )

        vim.keymap.set('n', "<leader>flS", function()
                builtin.lsp_dynamic_workspace_symbols()
            end,
            { desc = "List of dynamic workspace symbols" }
        )

        vim.keymap.set('n', "<leader>fldd", function()
                builtin.diagnostics({ bufnr = 0, initial_mode = 'normal' })
            end,
            { desc = "List of diagnostics document" }
        )

        vim.keymap.set('n', "<leader>flii",
            "<cmd> lua require('telescope.builtin').lsp_implementations({initial_mode = 'normal'})<CR> ", {
                desc = "List of implementations"
            })

        vim.keymap.set('n', "<leader>fldD",
            "<cmd> lua require('telescope.builtin').lsp_type_definitions({initial_mode = 'normal'})<CR> ", {
                desc = "List of type definitions"
            }
        )

        vim.keymap.set("n", "<leader>fh", function()
                builtin.help_tags()
            end,
            { desc = "List of help tags" }
        )

        vim.keymap.set('n', "<Leader>f/", function()
                builtin.resume()
            end,
            { desc = "Resume last telescope" }
        )

        vim.keymap.set('n', "<Leader>fi", function()
                builtin.highlights()
            end,
            { desc = "Lists all available highlights" }
        )
    end
}
