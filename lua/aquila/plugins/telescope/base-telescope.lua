return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    opts = function()
        local actions = require('telescope.actions')
        return {
            defaults = {
                mappings = {
                    n = {
                        ['q'] = actions.close
                    }
                }
            },
        }
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    lazy = true,
    cmd = "Telescope",
    keys = {
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
                require('telescope.builtin').help_tags()
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
    },
}