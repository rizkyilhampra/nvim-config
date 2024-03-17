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
            }
        }
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "kkharji/sqlite.lua",
        {
            "danielfalk/smart-open.nvim",
            branch = "0.2.x",
            keys = {
                {
                    "<leader><space>",
                    function()
                        require('telescope').extensions.smart_open.smart_open(require('telescope.themes').get_dropdown({
                            -- winblend = 10,
                            cwd_only = true,
                            devicons_enabled = true,
                            initial_mode = 'normal',
                            match_algorithm = 'fzf',
                        }))
                    end,
                    desc = "Find files in cwd"
                },
            },
            config = function()
                require('telescope').load_extension('smart_open')
            end
        },
        {
            "isak102/telescope-git-file-history.nvim",
            dependencies = { "tpope/vim-fugitive" },
            keys = {
                {
                    "<Leader>fg",
                    "<cmd>Telescope git_file_history<CR>",
                    desc = "List of git file history"

                }
            },
            config = function()
                require('telescope').load_extension('git_file_history')
            end
        },
        {
            "debugloop/telescope-undo.nvim",
            keys = {
                {
                    "<Leader>fu",
                    "<cmd>Telescope undo<CR>",
                    desc = "List of undos"
                }
            },
            config = function()
                require('telescope').load_extension('undo')
            end
        }
    },
    keys = {
        {
            '<leader>fa',
            function()
                require('telescope.builtin').find_files({
                    no_ignore = true,
                    hidden = true,
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
            "<Leader><Tab>",
            function()
                require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown({
                    previewer = false,
                    initial_mode = 'normal',
                    cwd_only = true,
                }))
            end,
            desc = 'List previously open files on cwd'
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